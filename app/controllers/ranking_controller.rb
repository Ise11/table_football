class RankingController < ApplicationController
  
  def index

	@players = (Player.all.sort_by { |player| -player.points_in_ranking})
	
  end
end