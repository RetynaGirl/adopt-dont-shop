require 'rails_helper'

# User Story 2, Shelter Index

# As a visitor
# When I visit '/shelters'
# Then I see the name of each shelter in the system

describe 'As a visitor' do
  describe "When I visit '/shelters'" do
    it 'see the name of each shelter in the system' do
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

      visit '/shelters'

      [shelter1, shelter2].each do |shelter|
        expect(page).to have_link(shelter.name.capitalize)
      end
    end
  end
end
