class Player < ActiveRecord::Base
	
  has_and_belongs_to_many :matches

  has_attached_file :avatar, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :default_url => "/images/:style/missing.png"
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\Z/

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
    points = 0
    today = Date.today
    self.matches.each do |match|
      if  ( today - 120.days < match.created_at ) &&  ( match.created_at <= today )
        points += self.won * self.points_per_game
      elsif ( today - 240.days < match.created_at ) && (match.created_at <= today - 120.days )
        points += 0.5*(self.won * self.points_per_game)
      elsif (today - 360.days < match.created_at ) && ( match.created_at <= today - 240.days ) 
        points += 0.25*(self.won * self.points_per_game)
      end  
    end
    
    return points.round(2)

  end
  
end
