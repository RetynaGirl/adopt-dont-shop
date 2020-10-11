require 'rails_helper'

# User Story 15, Pet Update From Pets Index Page

# As a visitor
# When I visit the pets index page or a shelter pets index page
# Next to every pet, I see a link to edit that pet's info
# When I click the link
# I should be taken to that pets edit page where I can update its information just like in User Story 11

describe 'As a visitor' do
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
  describe 'When I visit the pets index page or a shelter pets index page' do
    it 'Next to every pet on the pets index page, I see a link to edit that pets info' do
      visit '/pets'

      expect(page).to have_link('Update', count: Pets.count)
    end

    it 'Next to every pet on each shelters pets index page, I see a link to edit that pets info' do
      Shelter.all.each do |shelter|
        visit "/shelters/#{shelter.id}/pets"

        expect(page).to have_link('Update', shelter.pets.count)
      end
    end
  end
end
