require 'rails_helper'

# User Story 4, Shelter Creation

# As a visitor
# When I visit the Shelter Index page
# Then I see a link to create a new Shelter, "New Shelter"
# When I click this link
# Then I am taken to '/shelters/new' where I  see a form for a new shelter
# When I fill out the form with a new shelter's:
# - name
# - address
# - city
# - state
# - zip
# And I click the button "Create Shelter" to submit the form
# Then a `POST` request is sent to '/shelters',
# a new shelter is created,
# and I am redirected to the Shelter Index page where I see the new Shelter listed.

describe 'As a visitor' do
  describe 'when I visit the Shelter Index page' do
    it 'I see a link to create a new Shelter, "New Shelter"' do

      visit '/shelters'

      expect(page).to have_link("New Shelter")
    end

    it 'When I click this link I am taken to "/shelters/new" where I see a form for a new shelter' do
      visit '/shelters'

      click_link('New Shelter')

      expect(page).to have_button("Create Shelter")
    end

    it "When I fill out this form with a new shelter's info and click the 'Create Shelter' button" do
      visit '/shelters/new'

      fill_in('shelter[name]', with: 'Test Shelter')
      fill_in('shelter[address]', with: '123 Example St')
      fill_in('shelter[city]', with: 'Denver')
      fill_in('shelter[state]', with: 'CO')
      fill_in('shelter[zip]', with: '80304')

      click_on 'Create Shelter'

      expect(page).to have_link('Test Shelter')
    end
  end
end
