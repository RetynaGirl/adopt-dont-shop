require 'rails_helper'

# User Story 7, Pet Index

# As a visitor
# When I visit '/pets'
# Then I see each Pet in the system including the Pet's:
# - image
# - name
# - approximate age
# - sex
# - name of the shelter where the pet is currently located

# NOTE: Images should be stored as a string as the url pointing to an externally hosted image, for example: "https://dogtime.com/assets/uploads/2018/10/puppies-cover.jpg"

describe 'As a visitor' do
  describe 'when I visit "/pets"' do
    it 'I see each pet in the system with information/image' do
      shelter = Shelter.create(name: 'Bobby',
                               address: '123 halmock st',
                               city: 'dover',
                               state: 'florida',
                               zip: '12345')

      pet1 = Pet.create({
                          name: 'Charles',
                          image: 'https://images.dog.ceo/breeds/terrier-norwich/n02094258_230.jpg',
                          age: 3,
                          sex: 'Male',
                          shelter_id: shelter.id
                        })

      pet2 = Pet.create({
                          name: 'Lucy',
                          image: 'https://images.dog.ceo/breeds/pekinese/n02086079_606.jpg',
                          age: 6,
                          sex: 'Female',
                          shelter_id: shelter.id
                        })

      visit '/pets'

      expect(page).to have_link('Charles')
      expect(page).to have_content('3')
      expect(page).to have_content('Male')

      expect(page).to have_link('Lucy')
      expect(page).to have_content('6')
      expect(page).to have_content('Female')
    end
  end
end
