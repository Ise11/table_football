class Player < ActiveRecord::Base
	
  has_and_belongs_to_many :matches
  before_destroy { 
    self.matches.each do |match|
      match.destroy
    end
  }

  has_attached_file :avatar, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :default_url => "/images/:style/missing.png"
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\Z/

  #validates_presence_of :first_name, :last_name
  validates :first_name, presence: true, length: 2..15
  validates :last_name, presence: true, length: 2..15
  
  def fullname 
    "#{self.first_name} #{self.last_name}"
  end


  def statistics
    [["First name", self.first_name],["Last name", self.last_name], ["Goals", self.goals], 
    ["Points per game", self.points_per_game], ["Played", "#{self.how_many_matches} matches"], 
    ["Won", "#{self.won} matches"], ["Lose", "#{self.lose} matches"]] 
  end

  def goals

    goals = 0
    self.matches.each do |match|
      if match.winner == self.id
        goals += 10
      else
        goals += match.loser_score
      end
    end
    return goals
  end

  def won
  	won = 0
  	self.matches.each do |match|
      if match.winner == self.id
        won += 1
      end
    end
    return won
  end

  def lose
  	lose = 0
  	self.matches.each do |match|
      if match.loser == self.id
        lose += 1
      end
    end
    return lose
  end

  def how_many_matches
    self.matches.size
  end

  def points_per_game
    (goals.to_f/self.how_many_matches.to_f ).round(2)
  end

  def points_in_ranking
    (self.won * self.points_per_game).round(2)
  end

  def get_index 
    (Player.all.sort_by { |player| -player.points_in_ranking})
  end  
end
