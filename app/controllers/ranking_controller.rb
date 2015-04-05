class RankingController < ApplicationController
  def index
  	@rank = Hash.new 
 	@players = Player.all

 	@players.each do |player|
	@rank[player.id] = player.points_in_ranking 
	end
	@rank = @rank.sort_by {|_key, value| value}.reverse
	
  end
end