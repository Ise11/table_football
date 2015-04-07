require 'rails_helper'

describe Match do 

	context 'validate player model' do

		it 'shold validate a valid player' do
			player = Player.create(first_name: 'Edc', last_name: "Cde")
			expect(player).to be_valid
		end 

		it 'should show error for invalid player, having no first_name' do
			player = Player.create(first_name: nil, last_name: "Cde")
			expect(player).to have(1).errors_on(:first_name)
		end

		it 'should show error for invalid player, having no last_name' do
			player = Player.create(first_name: 'Edc', last_name: nil)
			expect(player).to have(1).errors_on(:last_name)
		end
	end