class Match < ActiveRecord::Base

	has_and_belongs_to_many :players

	
	validate :select_fields_are_not_equal

	def select_fields_are_not_equal
   		 self.errors.add(:base, 'Player 1 and Player 2 cannot be the same.') if self.winner == self.loser
  	end
	


	
end
