require 'rails_helper'

# User Story 8, Shelter Pets Index

# As a visitor
# When I visit '/shelters/:shelter_id/pets'
# Then I see each Pet that can be adopted from that Shelter with that shelter_id including the Pet's:
# - image
# - name
# - approximate age
# - sex

describe 'As a visitor' do
  describe 'When I visit "/shelters/:shelter_id/pets"' do
    it "I see each Pet that can be adopted from that Shelter with that shelter_id including the Pet's info" do
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

      visit "/shelters/#{shelter.id}/pets"

      [pet1, pet2].each do |pet|
        expect(page).to have_link(pet.name)
        expect(page).to have_xpath("//img[@src='#{pet.image}']")
        expect(page).to have_content(pet.age)
        expect(page).to have_content(pet.sex)
      end
    end
  end
end
