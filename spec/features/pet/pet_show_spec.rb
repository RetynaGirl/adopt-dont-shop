require 'rails_helper'

# User Story 9, Pet Show

# As a visitor
# When I visit '/pets/:id'
# Then I see the pet with that id including the pet's:
# - image
# - name
# - description
# - approximate age
# - sex
# - adoptable/pending adoption status

describe 'As a visitor' do
  describe 'When I visit "/pets/:id"' do
    it 'I see the pet with that id and information' do
      pet1 = Pet.create({
                          name: 'Charles',
                          image: 'https://images.dog.ceo/breeds/terrier-norwich/n02094258_230.jpg',
                          age: 3,
                          sex: 'Male',
                          adoptable: true,
                          description: 'this is a dog',
                          shelter_id: shelter.id
                        })

      visit "/pets/#{pet1.id}"

      expect(page).to have_content(pet1.name)
      expect(page).to have_content(pet1.description.capitalize)
      expect(page).to have_content(pet1.age)
      expect(page).to have_content(pet1.sex)
      expect(page).to have_xpath("//img[@src='#{pet1.image}']")
      expect(page).to have_link(Shelter.find(pet.shelter_id).name.split.map(&:capitalize).join(' '))
    end
  end
end
