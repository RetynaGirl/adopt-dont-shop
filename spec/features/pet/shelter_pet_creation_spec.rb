require 'rails_helper'

# User Story 10, Shelter Pet Creation

# As a visitor
# When I visit a Shelter Pets Index page
# Then I see a link to add a new adoptable pet for that shelter "Create Pet"
# When I click the link
# I am taken to '/shelters/:shelter_id/pets/new' where I see a form to add a new adoptable pet
# When I fill in the form with the pet's:
# - image
# - name
# - description
# - approximate age
# - sex ('female' or 'male')
# And I click the button "Create Pet"
# Then a `POST` request is sent to '/shelters/:shelter_id/pets',
# a new pet is created for that shelter,
# that pet has a status of 'adoptable',
# and I am redirected to the Shelter Pets Index page where I can see the new pet listed

describe 'As a visitor' do
  describe 'When I visit a Shelter Pets Index page' do
    it 'I see a link to add a new adopatable pet for that shelter "Create Pet"' do
      shelter = Shelter.create(name: 'Bobby',
                               address: '123 halmock st',
                               city: 'dover',
                               state: 'florida',
                               zip: '12345')

      visit "/shelters/#{shelter.id}/pets"

      expect(page).to have_link('Create Pet')
    end
  end

  describe 'When I click the Create Pet link on a Shelter Pets Index page' do
    describe 'I am taken to /shelters/:shelter_id/pets/new where I see a form for a new pet' do
      it 'When I fill out the form' do
        shelter = Shelter.create(name: 'Bobby',
                                 address: '123 halmock st',
                                 city: 'dover',
                                 state: 'florida',
                                 zip: '12345')

        visit "/shelters/#{shelter.id}/pets"

        click_link('Create Pet')

        fill_in('pet[name]', with: 'Charlie')
        fill_in('pet[image]', with: 'https://images.dog.ceo/breeds/cotondetulear/100_2397.jpg')
        fill_in('pet[description]', with: 'This is a dog')
        fill_in('pet[age]', with: 4)
        select('Male', from: 'pet[sex]')

        click_on("Create Pet")

        expect(page).to have_current_path("/shelters/#{shelter.id}/pets")

        expect(page).to have_link('Charlie')
        expect(page).to have_content('4')
        expect(page).to have_content('Male')
        expect(page).to have_xpath("//img[@src='https://images.dog.ceo/breeds/cotondetulear/100_2397.jpg']")
      end
    end
  end
end
