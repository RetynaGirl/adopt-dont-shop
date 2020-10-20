require 'rails_helper'

# User Story 27, All Pets Accepted on an Application

# As a visitor
# When I visit an admin application show page
# And I approve all pets for an application
# Then I am taken back to the admin application show page
# And I see the application's status has changed to "Approved"

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
                                        status: 'Pending'
                                      })

    

    @app1_pet1 = ApplicationPet.create(application: @application, pet: @pet1)
    @app1_pet2 = ApplicationPet.create(application: @application, pet: @pet2)
  
  end
  describe "When I visit an admin application show page" do
    it "And I approve all pets on an application the the admin app show page changes status approved" do
      visit "/admin/applications/#{@application.id}"
      within ("#application-pet-#{@pet1.id}") do
        click_button('Approve Pet')
      end
      expect(page).to have_content("Application Status: Pending")
      
      within ("#application-pet-#{@pet2.id}") do
        click_button('Approve Pet')
      end

      expect(page).to have_content("Application Status: Approved")

    end
    it "And I reject a pet on an application the the admin app show page changes status rejected" do
      visit "/admin/applications/#{@application.id}"
      within ("#application-pet-#{@pet1.id}") do
        click_button('Reject Pet')
      end
      expect(page).to have_content("Application Status: Rejected")
    end
  end
end
