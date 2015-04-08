class MatchesController < ApplicationController
  before_action :set_match, only: [:show, :edit, :update, :destroy]

  def index
    @matches = Match.all
  end

  def show    
  end

  def new
    @players = Player.all
    @match = Match.new
    @list = @players.map{ |p| ["#{p.last_name} #{p.first_name}" , p.id] } 
  end

  def edit
    @players = Player.all
    @match = Match.new
    @list = @players.map{ |p| ["#{p.last_name} #{p.first_name}" , p.id] }
  end

  def create

    @players = Player.all
    @match = Match.new
    @list = @players.map{ |p| ["#{p.last_name} #{p.first_name}" , p.id] }
    @match = Match.new(match_params)

    respond_to do |format|
      if @match.save
        format.html { redirect_to matches_path, notice: 'Match was successfully created.' }
        format.json { render :show, status: :created, location: @match }
      else
        format.html { render :new }
        format.json { render json: @match.errors, status: :unprocessable_entity }
      end
    end

    Player.find_by_id(@match.winner).matches << @match
    Player.find_by_id(@match.loser).matches << @match
    
  end

  def update
    respond_to do |format|
      if @match.update(match_params)
        format.html { redirect_to @match, notice: 'Match was successfully updated.' }
        format.json { render :show, status: :ok, location: @match }
      else
        format.html { render :edit }
        format.json { render json: @match.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @match.destroy
    respond_to do |format|
      format.html { redirect_to matches_url, notice: 'Match was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  
  def set_match
    @match = Match.find(params[:id])
  end


  def match_params
    params.require(:match).permit(:winner, :loser, :match_date, :loser_score)
  end
end
