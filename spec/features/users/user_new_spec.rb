require 'rails_helper'


# User Story 3, New User
# As a visitor
# When I visit '/users/new'
# I see a form to create a new user
# When I fill in the form with my
#   - Name
#   - Street Address
#   - City
#   - State
#   - Zip
# Then I am taken to my new user's show page
# And I see all of the information I entered in the form

describe 'As a visitor' do
  describe "When i visit '/users/new" do
    it 'I see a form to create a new user' do
      visit 'users/new'

      expect(page).to have_field('user[name]')
      expect(page).to have_field('user[address]')
      expect(page).to have_field('user[city]')
      expect(page).to have_field('user[state]')
      expect(page).to have_field('user[zip]')

    end
    it "when I fill in form and click 'submit' I'm directed to /user/:id and can see the form data" do

      visit "/users/new"
      fill_in('user[name]', with: 'Jake')
          fill_in('user[address]', with: '1234 First St.')
      fill_in('user[city]', with: 'Denver')
      fill_in('user[state]', with: 'CO')
      fill_in('user[zip]', with: '80123')

      click_button('Create User')
      expect(current_path).to eq("/users/#{User.last.id}")
    end
  end
end
