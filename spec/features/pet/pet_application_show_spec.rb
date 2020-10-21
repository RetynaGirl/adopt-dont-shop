require 'rails_helper'

# User Story 30, Pet Applications Index Page

# As a visitor
# When I visit a pets show page
# I see a link to view all applications for this pet
# When I click that link
# I can see a list of all the names of applicants for this pet
# Each applicants name is a link to the application's show page

# User Story 31, Pet Applications Index Page When No Applications

# As a visitor
# When I visit a pet applications index page for a pet that has no applications on them
# I see a message saying that there are no applications for this pet yet

describe 'As a visitor' do
  before(:each) do
    @shelter1 = Shelter.create(name: 'Great Shelter',
                               address: '123 halmock st',
                               city: 'Erie',
                               state: 'CO',
                               zip: '12345')

    @shelter2 = Shelter.create(name: 'Best Shelter',
                               address: '123 halmock st',
                               city: 'Fort Collins',
                               state: 'CO',
                               zip: '80345')

    @shelter3 = Shelter.create(name: 'Wonderful Shelter',
                               address: '45 Nordhelm st',
                               city: 'Erie',
                               state: 'CO',
                               zip: '80333')

    @user1 = User.create(name: 'Jake Smith',
                         address: '164 South St',
                         city: 'Denver',
                         state: 'CO',
                         zip: '80213')
    @user2 = User.create(name: 'Mark Humphrey',
                         address: '217 Mulberry St',
                         city: 'Englewood',
                         state: 'CO',
                         zip: '80213')

    @user3 = User.create(name: 'Jake Sprinter',
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
                         shelter_id: @shelter1.id
                       })
    @pet2 = Pet.create({
                         name: 'Maude',
                         image: 'https://images.dog.ceo/breeds/sheepdog-english/n02105641_24.jpg',
                         age: 2,
                         sex: 'Female',
                         adoptable: true,
                         description: 'obsesses about food',
                         shelter_id: @shelter2.id
                       })
    @pet3 = Pet.create({
                         name: 'Sally',
                         image: 'hhttps://images.dog.ceo/breeds/lhasa/n02098413_4238.jpg',
                         age: 6,
                         sex: 'Female',
                         adoptable: true,
                         description: 'this dog is a lot of fun',
                         shelter_id: @shelter2.id
                       })
    @pet4 = Pet.create({
                         name: 'Sparkles',
                         image: 'https://images.dog.ceo/breeds/bulldog-boston/n02096585_865.jpg',
                         age: 4,
                         sex: 'Male',
                         adoptable: true,
                         description: 'great dog',
                         shelter_id: @shelter2.id
                       })
    @pet5 = Pet.create({
                         name: 'Froofy',
                         image: 'https://images.dog.ceo/breeds/cairn/n02096177_7701.jpg',
                         age: 7,
                         sex: 'Female',
                         adoptable: true,
                         description: 'has terrible allergies',
                         shelter_id: @shelter1.id
                       })
    @application1 = Application.create({
                                         user: @user1,
                                         description: 'I have a great house for a dog',
                                         status: 'In Progress'
                                       })

    @application2 = Application.create({
                                         user: @user2,
                                         description: 'I love dogs',
                                         status: 'In Progress'
                                       })

    @application3 = Application.create({
                                         user: @user3,
                                         description: 'I love dogs',
                                         status: 'In Progress'
                                       })

    ApplicationPet.create(application: @application1, pet: @pet2)

    ApplicationPet.create(application: @application2, pet: @pet2)

    ApplicationPet.create(application: @application3, pet: @pet4)
    ApplicationPet.create(application: @application3, pet: @pet5)
  end

  describe 'When I visit a pets show page' do
    it 'I see a link to view all applications for this pet' do
      visit "/pets/#{@pet1.id}"

      expect(page).to have_link('View Applications')
    end

    it 'When I click the link I see a list of all applicants with applications containing that pet' do
      ApplicationPet.create(application: @application1, pet: @pet1)
      visit "/pets/#{@pet1.id}"

      click_link('View Applications')

      expect(page).to have_current_path("/pets/#{@pet1.id}/applications")
      save_and_open_page
      @pet1.applications.each do |application|
        expect(page).to have_link(application.user.name)
      end
    end
    describe 'Without any applications' do
      it 'I see a message saying there are not any applications' do
        visit "/pets/#{@pet1.id}/applications"

        expect(page).to have_content('There are no applications that contain this pet.')
      end
    end
  end
end
