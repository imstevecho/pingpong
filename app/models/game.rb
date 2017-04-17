require 'elo'

class Game < ActiveRecord::Base
  belongs_to :user
  belongs_to :opponent, class_name: :User

  validates_presence_of :user
  validates_presence_of :opponent

  validates_numericality_of :user_score, only_integer: true, greater_than_or_equal_to: 0
  validates_numericality_of :opponent_score, only_integer: true, greater_than_or_equal_to: 0
  validate :score_must_be_2_points_margin
  validate :winner_score_must_be_greater_than_21

  scope :my_games, -> (user_id) { where(user_id: user_id).includes([:user,:opponent]).order(date_played: :desc)}

  after_create :update_ranking


  def score
    "#{user_score}-#{opponent_score}"
  end

  def winner
    user_score > opponent_score ? user : opponent
  end

  def played_date
    "#{date_played.strftime('%b %d')}"
  end

  def result
    if user_score > opponent_score
      'W'
    elsif user_score < opponent_score
      'L'
    else
      'T'
    end
  end


  private

  def score_must_be_2_points_margin
    if user_score.present? && opponent_score.present?
      if (user_score - opponent_score).abs < 2
        errors.add(:user_score, "A game needs to be won by a two point margin")
      end
    end
  end

  def winner_score_must_be_greater_than_21
    if user_score.present? && opponent_score.present?
      if (user_score < 21 && opponent_score < 21)
        errors.add(:user_score, "Not a finished game")
      end
    end
  end


  def update_ranking

    if user.ranking.nil?
      myself_ranking = Ranking.create(user_id: user_id, score: 0, games_played: 0)
    else
      myself_ranking = user.ranking
    end

    if opponent.ranking.nil?
      opponent_ranking = Ranking.create(user_id: opponent_id, score: 0, games_played: 0)
    else
      opponent_ranking = opponent.ranking
    end

    myself = Elo::Player.new(score: myself_ranking.score)
    opponent = Elo::Player.new(score: opponent_ranking.score)

    if winner.id == user.id
      myself.wins_from(opponent)
    else
      opponent.wins_from(myself)
    end

    myself_ranking.update_attributes(games_played: myself_ranking.games_played + 1, score: myself_ranking.score + myself.rating)
    opponent_ranking.update_attributes(games_played: opponent_ranking.games_played + 1, score: opponent_ranking.score + opponent.rating)

  end


end
