require 'rails_helper'

# User Story 11, Pet Update

# As a visitor
# When I visit a Pet Show page
# Then I see a link to update that Pet "Update Pet"
# When I click the link
# I am taken to '/pets/:id/edit' where I see a form to edit the pet's data including:
# - image
# - name
# - description
# - approximate age
# - sex
# When I click the button to submit the form "Update Pet"
# Then a `PATCH` request is sent to '/pets/:id',
# the pet's data is updated,
# and I am redirected to the Pet Show page where I see the Pet's updated information

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
                        shelter_id: shelter.id
                      })

  end
  describe 'When I visit a Pet Show page' do
    it 'I see a link to update that pet "Update Pet"' do

      visit "/pets/#{@pet1.id}"

      expect(page).to have_link('Update Pet')


    end

    describe "When I clidk the 'Update Pet' link" do
      it "I am taken to '/pets/:id/edit' where I see a form to edit the pet's data" do
        visit "/pets/#{@pet1.id}"

        click_link('Update Pet')

        expect(page).to have_field('pet[name]')
      end

      describe "When I fill out the form with updated information and click 'Update Pet'" do
        it 'I am redirected to the pet show page with the updated pet information' do
          visit "/pets/#{@pet.id}/edit"

          fill_in('pet[name]', with: 'Dave')
          select('Female', from: 'pet[sex]')

          click_on('Update Pet')

          expect(page).to have_current_path("/pets/#{@pet1.id}")

          expect(page).to have_content('Female')
          expect(page).to have_content('Dave')
        end
      end
    end
  end
end
