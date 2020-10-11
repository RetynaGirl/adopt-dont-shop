require 'rails_helper'

# User Story 12, Pet Delete

# As a visitor
# When I visit a pet show page
# Then I see a link to delete the pet "Delete Pet"
# When I click the link
# Then a 'DELETE' request is sent to '/pets/:id',
# the pet is deleted,
# and I am redirected to the pet index page where I no longer see this pet

describe 'As a visitor' do
  before(:each) do
    @shelter = Shelter.create(name: 'Bobby',
                             address: '123 halmock st',
                             city: 'dover',
                             state: 'florida',
                             zip: '12345')

    @pet1 = Pet.create({
                        name: 'Charles',
                        image: 'https://images.dog.ceo/breeds/terrier-norwich/n02094258_230.jpg',
                        age: 3,
                        sex: 'Male',
                        adoptable: true,
                        description: 'this is a dog',
                        shelter_id: @shelter.id
                      })

  end

  describe 'When I visit a pet show page' do
    it 'I see a link to delete the pet "Delete Pet"' do
      visit "/pets/#{@pet1.id}"

      expect(page).to have_button("Delete Pet")
    end
  end

  describe 'When I click the Delete Pet button' do
    it 'it deletes the pet and I am redirected to the pet index page without this pet' do
      visit "/pets/#{@pet1.id}"

      click_on('Delete Pet')

      expect(page).to have_current_path('/pets')

      expect(page).to have_no_link(@pet1.name.split.map(&:capitalize).join(' '))
    end
  end
end
