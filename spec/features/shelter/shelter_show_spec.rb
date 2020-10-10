require 'rails_helper'

# User Story 3, Shelter Show

# As a visitor
# When I visit '/shelters/:id'
# Then I see the shelter with that id including the shelter's:
# - name
# - address
# - city
# - state
# - zip

describe 'As a visitor' do
  describe "When I visit '/shelters/:id'" do
    it "see the shelter with that id including the shelter's info" do
      shelter = Shelter.create(name: 'Bobby',
                               address: '123 halmock st',
                               city: 'dover',
                               state: 'florida',
                               zip: '12345')

      visit "/shelters/#{shelter.id}"

      expect(page).to have_content(shelter.name)
      expect(page).to have_content(shelter.address)
      expect(page).to have_content(shelter.city)
      expect(page).to have_content(shelter.state)
      expect(page).to have_content(shelter.zip)
    end
  end
end
