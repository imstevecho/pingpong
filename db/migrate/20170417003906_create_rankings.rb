class CreateRankings < ActiveRecord::Migration
  def change
    create_table :rankings do |t|
      t.integer :user_id
      t.integer :score
      t.integer :games_played

      t.timestamps null: false
    end
  end
end
