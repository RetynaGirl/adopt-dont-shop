require 'rails_helper'


# User Story 14, Shelter Delete From Shelter Index Page

# As a visitor
# When I visit the shelter index page
# Next to every shelter, I see a link to delete that shelter
# When I click the link
# I am returned to the Shelter Index Page where I no longer see that shelter

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

      expect(page).to have_button('Delete', count: Shelter.count)
    end
  end

  describe 'When I click the button' do
    it 'the shelter is deleted' do
      visit '/shelters'



      page.all('.shelter-action-button').each do |button|
        button.click
      end

      page.find('.shelter-action-button').click

      expect(page).to_not have_button('Delete')
    end
  end
end
