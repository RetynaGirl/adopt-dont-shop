require 'rails_helper'

# User Story 25, Approving a Pet for Adoption

# As a visitor
# When I visit an admin application show page ('/admin/applications/:id')
# For every pet that the application is for, I see a button to approve the application for that specific pet
# When I click that button
# Then I'm taken back to the admin application show page
# And next to the pet that I approved, I do not see a button to approve this pet
# And instead I see an indicator next to the pet that they have been approved

describe 'As a visitor' do
  before(:each) do
    @shelter = Shelter.create(name: 'Bobby',
                              address: '123 halmock st',
                              city: 'dover',
                              state: 'florida',
                              zip: '12345')
    @user = User.create(name: 'Jake',
                        address: '1234 1st St',
                        city: 'Denver',
                        state: 'CO',
                        zip: '80213')
    @pet1 = Pet.create({
                         name: 'Jack',
                         image: 'https://images.dog.ceo/breeds/affenpinscher/n02110627_13014.jpg',
                         age: 4,
                         sex: 'Male',
                         adoptable: true,
                         description: 'small black dog',
                         shelter_id: @shelter.id
                       })
    @pet2 = Pet.create({
                         name: 'Charles',
                         image: 'https://images.dog.ceo/breeds/terrier-norwich/n02094258_230.jpg',
                         age: 2,
                         sex: 'Male',
                         adoptable: true,
                         description: 'this is a dog',
                         shelter_id: @shelter.id
                       })
    @pet3 = Pet.create({
                         name: 'Rascal',
                         image: 'https://images.dog.ceo/breeds/spaniel-sussex/n02102480_5808.jpg',
                         age: 3,
                         sex: 'Male',
                         adoptable: true,
                         description: 'this dog has won some medals',
                         shelter_id: @shelter.id
                       })
    @application = Application.create({
                                        user: @user,
                                        description: 'I have a great house for a dog',
                                        status: 'In Progress'
                                      })

    ApplicationPet.create(application: @application, pet: @pet1)
    ApplicationPet.create(application: @application, pet: @pet2)
  end

  describe 'When I visit an admin application show page' do
    it 'For every pet that the application is for, I see a button to approve the application for that specific pet' do
      visit "/admin/applications/#{@application.id}"

      @application.pets.each do |pet|
        within("#application-pet-#{pet.id}") do
          expect(page).to have_button('Approve Pet')
        end
      end
    end

    it 'When I click the button I am taken back to the admin application show page and the pet is now approved' do
      visit "/admin/applications/#{@application.id}"

      within("#application-pet-#{@pet1.id}") do
        click_button('Approve Pet')
      end

      expect(page).to have_current_path("/admin/applications/#{@application.id}")

      within("#application-pet-#{@pet1.id}") do

        expect(page).to_not have_button('Approve Pet')
        expect(page).to have_content('Approved!')
      end
    end
  end
end
