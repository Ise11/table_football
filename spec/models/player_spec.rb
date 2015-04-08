require 'rails_helper'

describe Player do 

	context 'validate player model' do

		it 'shold validate a valid player' do
			player = Player.create(first_name: 'Edc', last_name: "Cde")
			expect(player).to be_valid
		end 

		it 'should show error for invalid player, having no first_name ( & to short name)' do
			player = Player.create(first_name: nil, last_name: "Cde")
			expect(player).to have(2).errors_on(:first_name)
		end

		it 'should show error for invalid player, having no last_name ( & to short name)' do
			player = Player.create(first_name: 'Edc', last_name: nil)
			expect(player).to have(2).errors_on(:last_name)
		end
	end

	context 'functions test' do

		player1 = Player.create(first_name: 'Rfv', last_name: "Vfr")
		player2 = Player.create(first_name: 'Edc', last_name: "Cde")
		player3 = Player.create(first_name: 'Tgb', last_name: "Bgt")

		match1=Match.create(winner: player1.id, loser: player2.id, loser_score: 6)
		match2=Match.create(winner: player1.id, loser: player3.id, loser_score: 8)
		match3=Match.create(winner: player2.id, loser: player1.id, loser_score: 7)
		match4=Match.create(winner: player3.id, loser: player2.id, loser_score: 3)
		match5=Match.create(winner: player3.id, loser: player1.id, loser_score: 2)
		match6=Match.create(winner: player1.id, loser: player2.id, loser_score: 7)

		player1.matches << [match1, match2, match3, match5, match6]
		player2.matches << [match1, match3, match4, match6]
		player3.matches << [match2, match4, match5]
		

		it 'should return right value for how_many_matches' do

			expected_result_how_many_matches = 5
			real_result = player1.how_many_matches
			expect(real_result).to eq expected_result_how_many_matches
			
			expected_result_how_many_matches = 4
			real_result = player2.how_many_matches
			expect(real_result).to eq expected_result_how_many_matches

			
		end

		it 'should return right value for won' do
			expected_won_result = 3
			real_result = player1.won
			expect(real_result).to eq expected_won_result

			expected_won_result = 2
			real_result = player3.won
			expect(real_result).to eq expected_won_result
		end

		it 'should return right value for lose' do
			expected_lose_result = 3
			real_result = player2.lose
			expect(real_result).to eq expected_lose_result

			expected_lose_result = 1
			real_result = player3.lose
			expect(real_result).to eq expected_lose_result
		end
		

		it 'should return right value for goals' do
			expected_goals_result = 39
			real_result = player1.goals
			expect(real_result).to eq expected_goals_result

			expected_goals_result = 28
			real_result = player3.goals
			expect(real_result).to eq expected_goals_result
		end

		it 'should return right value for points_per_game' do
			expected_points_per_game_result = 7.8
			real_result = player1.points_per_game
			expect(real_result).to eq expected_points_per_game_result

			expected_points_per_game_result = 9.33
			real_result = player3.points_per_game
			expect(real_result).to eq expected_points_per_game_result
		end


		it 'should return right value for points_in_ranking' do
			expected_points_in_ranking_result = 23.4
			real_result = player1.points_in_ranking
			expect(real_result).to eq expected_points_in_ranking_result

			expected_points_in_ranking_result = 6.5
			real_result = player2.points_in_ranking
			expect(real_result).to eq expected_points_in_ranking_result
		end




	end
	
end