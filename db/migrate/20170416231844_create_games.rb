class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.timestamp :date_played
      t.integer :user_id
      t.integer :user_score
      t.integer :opponent_id
      t.integer :opponent_score

      t.timestamps null: false
    end
  end
end
