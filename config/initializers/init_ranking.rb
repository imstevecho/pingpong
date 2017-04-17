# Initialize Ranking for the first time
if (User.table_exists? && Ranking.table_exists?)
  (User.all.pluck(:id) - Ranking.all.pluck(:user_id)).each do |user_id|
    Ranking.create(user_id: user_id, score: 0, games_played: 0)
  end
end