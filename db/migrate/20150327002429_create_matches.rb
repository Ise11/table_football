class CreateMatches < ActiveRecord::Migration
  def change
    create_table :matches do |t|
      t.integer :winner
      t.integer :loser
      t.date :match_date
      t.integer :loser_score

      t.timestamps null: false
      
    end
  end
end
