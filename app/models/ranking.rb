class Ranking < ActiveRecord::Base
  belongs_to :user
  validates_presence_of :user, :games_played, :score

  default_scope { order(score: :desc)}


end
