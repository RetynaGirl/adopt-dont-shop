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
  end
  describe "the pet search can handle a variety of searches" do
    it "complete name searches" do
      visit "/applications/#{@application.id}"
      fill_in "search", with: "Rascal"
      click_button("Search")
      within('#pet-search') do
        expect(page).to have_content("Rascal")
      end
    end
    it "wild card searches" do
      visit "/applications/#{@application.id}"
      fill_in "search", with: "asc"
      click_button("Search")
      within('#pet-search') do
        expect(page).to have_content("Rascal")
      end
    end
    it "case insensitive searches" do
      visit "/applications/#{@application.id}"
      fill_in "search", with: "ra"
      click_button("Search")
      within('#pet-search') do
        expect(page).to have_content("Rascal")
      end
    end
  end
  describe 'Next to each pet returned in search there is a button to add them to app' do
    it 'when clicked, the button adds the pet and returns me to the application show page' do
      visit "/applications/#{@application.id}"
      expect(page).to_not have_selector("#application-pet-#{@pet3.id}")
      fill_in "search", with: "ra"
      click_button("Search")
      within("#pet-search-#{@pet3.id}") do
        expect(page).to have_content("Rascal")
        click_button("Add to Application")
      end
      expect(current_path).to eq("/applications/#{@application.id}")
      within("#application-pet-#{@pet3.id}") do
        expect(page).to have_content("Rascal")
      end
    end
  end
end

describe 'as a vistor' do
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
                      description: "I have a great house for a dog",
                      status: "In Progress"})
  end
  describe 'when I fill out an application' do
    it "I can input why I'd make a good owner only after I've added a pet" do
      visit "/applications/#{@application.id}"
      expect(page).to_not have_selector('owner-reason')
      fill_in "search", with: "ra"
      click_button("Search")
      within("#pet-search-#{@pet3.id}") do
        click_button("Add to Application")
      end
      expect(page).to have_selector("#owner-reason")

    end
    it 'I can submit an application only when I add a pet to the application' do
      visit "/applications/#{@application.id}"
      expect(page).to_not have_button('Submit')
      fill_in "search", with: "ra"
      click_button("Search")
      within("#pet-search-#{@pet3.id}") do
        click_button("Add to Application")
      end
      expect(page).to have_button("Submit Application")

    end
    it 'I can add a pet to an application more than once' do
      visit "/applications/#{@application.id}"
      fill_in "search", with: "ra"
      click_button("Search")
      within("#pet-search-#{@pet3.id}") do
        click_button("Add to Application")
      end
      expect(@application.pets.size).to eq(1)

    end
  end
end
