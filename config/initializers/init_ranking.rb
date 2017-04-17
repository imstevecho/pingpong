# Initialize Ranking for the first time
(User.all.pluck(:id) - Ranking.all.pluck(:user_id)).each do |user_id|
  puts "creating ranking for #{user_id} ........"
  Ranking.create(user_id: user_id, score: 0, games_played: 0)
end