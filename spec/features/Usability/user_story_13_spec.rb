require 'rails_helper'

# User Story 13, Shelter Update From Shelter Index Page

# As a visitor
# When I visit the shelter index page
# Next to every shelter, I see a link to edit that shelter's info
# When I click the link
# I should be taken to that shelters edit page where I can update its information just like in User Story 5

describe 'As a user' do
  before(:each) do
    shelter1 = Shelter.create(name: 'Bobby',
                                address: '123 halmock st',
                                city: 'dover',
                                state: 'florida',
                                zip: '12345')
      shelter2 = Shelter.create(name: 'Joe',
                                address: '123 bismark st',
                                city: 'london',
                                state: 'texas',
                                zip: '67890')
  end
  describe 'When I visit the shelter index page' do
    it 'Next to every shelter, I see a link to edit that shelters info' do
      visit '/shelters'

      expect(page).to have_link('Update', count: Shelter.count)
    end
  end

  describe 'When I click the link' do
    it 'I am taken to the page to edit that shelter' do
      visit '/shelters'

      shelters = Shelter.all
      shelters.each do |shelter|
        visit "/shelters/#{shelter.id}/edit"

        expect(page).to have_current_path("/shelters/#{shelter.id}/edit")
      end
    end
  end
end
