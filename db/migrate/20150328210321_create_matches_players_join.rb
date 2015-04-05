class CreateMatchesPlayersJoin < ActiveRecord::Migration

  def up
    create_table :matches_players, :id => false do |t|
    	t.integer "match_id"
    	t.integer "player_id"
    	
    end
    add_index :matches_players, ["match_id","player_id"]
  end

  def down
  	drop_table :matches_players
  end
end
