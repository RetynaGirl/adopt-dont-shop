require 'rails_helper'

# User Story 2, User Show Page

# As a visitor
# When I visit a User's show page
# Then I see all that User's information
# Including the User's
#   - Name
#   - Street Address
#   - City
#   - State
#   - Zip

describe 'As a visitor' do
  describe "When I visit a User's show page" do
    before(:each) do
      @user1 = User.create!(
                            name: 'Jake',
                            address: '1234 1st St',
                            city: 'Denver',
                            state: 'CO',
                            zip: '80213'
      )
    end
    it "I see all that User's information" do
      visit "/users/#{@user1.id}"

      expect(page).to have_content(@user1.name)
      expect(page).to have_content(@user1.address)
      expect(page).to have_content(@user1.city)
      expect(page).to have_content(@user1.state)
      expect(page).to have_content(@user1.zip)
    end
  end
end
