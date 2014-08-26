require 'rails_helper'

describe 'payments' do
	before(:each) do
		post = create(:post)
		post.create_tags
	end

	context 'when not logged in' do
		it 'user cannot buy pictures' do
			visit '/posts'
			click_link 'Buy test2'
			expect(current_path).to eq new_user_session_path
		end
	end

	context 'when logged in' do
		before(:each) do
			dave = create(:user)
			login_as dave
		end

		it 'user can go to buy form' do
			visit '/posts'
			click_link 'Buy test2 - £2.50'
			expect(current_path).to eq new_charge_path
			expect(page).to have_content "Amount: £2.50"
		end
	end
end