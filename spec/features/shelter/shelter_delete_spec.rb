require 'rails_helper'

# User Story 6, Shelter Delete

# As a visitor
# When I visit a shelter show page
# Then I see a link to delete the shelter
# When I click the link "Delete Shelter"
# Then a 'DELETE' request is sent to '/shelters/:id',
# the shelter is deleted,
# and I am redirected to the shelter index page where I no longer see this shelter

describe 'As a visitor' do
  describe 'When I visit a shelter show page' do
    it 'I see a link to delete the shelter' do
      shelter = Shelter.create(name: 'Bobby',
                               address: '123 halmock st',
                               city: 'dover',
                               state: 'florida',
                               zip: '12345')

      visit "/shelters/#{shelter.id}"

      expect(page).to have_button('Delete')
    end
  end

  describe 'When I click the link "Delete Shelter"' do
    it 'the shelter is deleted and I get sent to the shelter index page without the shelter' do
      shelter = Shelter.create(name: 'Bobby',
                               address: '123 halmock st',
                               city: 'dover',
                               state: 'florida',
                               zip: '12345')

      visit "/shelters/#{shelter.id}"

      click_on('Delete')

      expect(page).to have_link('New Shelter')

      expect(page).to have_no_link('Bobby')
    end
  end
end
