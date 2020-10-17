require 'rails_helper'

# User Story 15, Application Show Page

# PAIR STORY: It is recommended that you work on this story as a pair. Both partners should understand the data model for applications and how they relate to other models.

# As a visitor
# When I visit an applications show page "/applications/:id"
# Then I can see the following:
# - Name of the User on the Application
# - Full Address of the User on the Application
# - Description of why the applicant says they'd be a good home for this pet(s)
# - names of all pets that this application is for (all names of pets should be links to their show page)

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
      @application = Application.create({
                        user: @user,
                        description: "I have a great house for a dog",
                        status: "In Progress"
      })

      ApplicationPet.create(application: @application, pet: @pet1)
      ApplicationPet.create(application: @application, pet: @pet2)

  end
  describe 'when i visit application show page' do
    it 'I see application user name, address, description, pets user applying for' do
      visit "/applications/#{@application.id}"

      expect(page).to have_content(@application.user.name)
      expect(page).to have_content(@application.user.address)
      expect(page).to have_content(@application.user.city)
      expect(page).to have_content(@application.user.state)
      expect(page).to have_content(@application.user.zip)
      expect(page).to have_content(@application.description)
      expect(page).to have_content(@application.status)
      @application.pets.each do |pet|
        expect(page).to have_link(pet.name)
      end
    end
    it "I see a search bar that returns a list of pet names similar to my search" do
      visit "/applications/#{@application.id}"
      fill_in "search[names]", with: "Ja"
      click_button("Search Pet Names")
      within('#pet-search') do
        expect(page).to have_content("Jack")
      end

    end
      
  end
end
