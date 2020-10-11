require 'rails_helper'

# User Story 23, Shelter Pet Count

# As a visitor
# When I visit a shelter pets index page
# I see a count of the number of pets at this shelter

describe 'As a visitor' do
  before(:each) do
    @shelter1 = Shelter.create(name: 'Bobby',
                               address: '123 halmock st',
                               city: 'dover',
                               state: 'florida',
                               zip: '12345')
    @shelter2 = Shelter.create(name: 'Joe',
                               address: '123 bismark st',
                               city: 'london',
                               state: 'texas',
                               zip: '67890')

    @pet1 = Pet.create({
                         name: 'Wasabi',
                         image: 'https://images.dog.ceo/breeds/terrier-norwich/n02094258_230.jpg',
                         age: 3,
                         sex: 'Male',
                         adoptable: true,
                         description: 'this is a dog',
                         shelter_id: @shelter1.id
                       })
    @pet2 = Pet.create({
                         name: 'sucky',
                         image: 'https://images.dog.ceo/breeds/terrier-norwich/n02094258_230.jpg',
                         age: 3,
                         sex: 'Male',
                         adoptable: true,
                         description: 'this is a dog',
                         shelter_id: @shelter1.id
                       })
    @pet3 = Pet.create({
                         name: 'Wasabi',
                         image: 'https://images.dog.ceo/breeds/terrier-norwich/n02094258_230.jpg',
                         age: 3,
                         sex: 'Male',
                         adoptable: true,
                         description: 'this is a dog',
                         shelter_id: @shelter2.id
                       })
    @pet4 = Pet.create({
                         name: 'Wasabi',
                         image: 'https://images.dog.ceo/breeds/terrier-norwich/n02094258_230.jpg',
                         age: 3,
                         sex: 'Male',
                         adoptable: true,
                         description: 'this is a dog',
                         shelter_id: @shelter2.id
                       })
  end
  describe 'When I visit a shelter pets index page' do
    it 'I see a count of the number of pets at this shelter' do
      visit "/shelters/#{@shelter1.id}/pets"

      expect(page).to have_content(@shelter1.pets.count)
    end
  end
end
