require 'rails_helper'

# User Story 5, Shelter Update

# As a visitor
# When I visit a shelter show page
# Then I see a link to update the shelter "Update Shelter"
# When I click the link "Update Shelter"
# Then I am taken to '/shelters/:id/edit' where I  see a form to edit the shelter's data including:
# - name
# - address
# - city
# - state
# - zip
# When I fill out the form with updated information
# And I click the button to submit the form
# Then a `PATCH` request is sent to '/shelters/:id',
# the shelter's info is updated,
# and I am redirected to the Shelter's Show page where I see the shelter's updated info

describe 'As a visitor' do
  describe 'When I visit a shelter show page' do
    it 'I see a link to update the shelter "Update Shelter"' do
      shelter = Shelter.create(name: 'Bobby',
                               address: '123 halmock st',
                               city: 'dover',
                               state: 'florida',
                               zip: '12345')

      visit "/shelters/#{shelter.id}"

      expect(page).to have_link('Update')
    end

    it "When I click the link I am taken to '/shelters/:id/edit' where I see a form to edit shelter info" do
      shelter = Shelter.create(name: 'Bobby',
                               address: '123 halmock st',
                               city: 'dover',
                               state: 'florida',
                               zip: '12345')

      visit "/shelters/#{shelter.id}/edit"

      expect(page).to have_button('Update')
    end

    it 'When I fill out the form and click the button to submit' do
      shelter = Shelter.create(name: 'Bobby',
                               address: '123 halmock st',
                               city: 'dover',
                               state: 'florida',
                               zip: '12345')

      visit "/shelters/#{shelter.id}/edit"

      fill_in('shelter[name]', with: 'Joe')
      fill_in('shelter[address]', with: 'new address')
      fill_in('shelter[city]', with: 'new city')
      fill_in('shelter[state]', with: 'new state')
      fill_in('shelter[zip]', with: 'new zip')

      click_on('Update Shelter')

      expect(page).to have_link('Update')

      expect(page).to have_content('Joe')
      expect(page).to have_content('new address')
      expect(page).to have_content('new city')
      expect(page).to have_content('new state')
      expect(page).to have_content('new zip')
    end
  end
end
