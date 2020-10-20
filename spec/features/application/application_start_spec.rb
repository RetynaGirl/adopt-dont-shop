require 'rails_helper'

# User Story 16, Starting an Application

# As a visitor
# When I visit the pet index page
# Then I see a link to "Start an Application"
# When I click this link
# Then I am taken to the new application page where I see a form
# When I fill in this form with my user name (assuming I have already created a user in the system)
# And I click submit
# Then I am taken to the new application's show page
# And I see my user listed along with all of my address information
# And I see an indicator that this application is "In Progress"

describe 'As a visitor' do
  describe 'When I visit the pet index page' do
    it 'I see a link to start an application' do
      visit '/pets'

      expect(page).to have_link('Start an Application')
    end

    it 'When I click the start application link I am taken to a new application page where I fill out the form and stuff' do
      @user1 = User.create(name: 'Jake Smith',
                           address: '164 South St',
                           city: 'Denver',
                           state: 'CO',
                           zip: '80213')

      visit '/pets'

      click_link('Start an Application')

      expect(page).to have_current_path('/applications/new')

      select('Jake Smith', from: 'application[user]')

      click_button('Submit')

      expect(page).to have_current_path("/applications/#{Application.last.id}")
    end
  end
end
