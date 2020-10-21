require 'rails_helper'

describe Shelter, type: :model do
  describe 'validations' do
    it do
      should validate_presence_of :name
      should validate_presence_of :address
      should validate_presence_of :city
      should validate_presence_of :state
      should validate_presence_of :zip
    end
  end

  describe 'relationships' do
    it do
       should have_many :pets
       should have_many :reviews
    end
  end

  describe 'instance methods' do
    before(:each) do
      @shelter1 = Shelter.create(name: 'Wonderful Shelter',
                           address: '45 Nordhelm st',
                           city: 'Erie',
                           state: 'CO',
                           zip: '80333')
      @shelter2 = Shelter.create(name: 'Best Shelter',
                           address: '123 halmock st',
                           city: 'Fort Collins',
                           state: 'CO',
                           zip: '80345')

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
                     shelter_id: @shelter1.id
                   })
      @pet3 = Pet.create({
                     name: 'Sally',
                     image: 'hhttps://images.dog.ceo/breeds/lhasa/n02098413_4238.jpg',
                     age: 6,
                     sex: 'Female',
                     adoptable: true,
                     description: 'this dog is a lot of fun',
                     shelter_id: @shelter1.id
                   })
      @user1 = User.create(name: "Jake",
                        address: '1234 1st St',
                        city: 'Denver',
                        state: 'CO',
                        zip: '80213') 
      @user2 = User.create(name: "Sally",
                        address: '1234 1st St',
                        city: 'Denver',
                        state: 'CO',
                        zip: '80213') 
      @review = Review.create(title:"Great shelter",
                            rating: 4,
                            content: "They treat their pets well.",
                            image: 'https://images.dog.ceo/breeds/hound-walker/n02089867_454.jpg',
                            user: @user1,
                            shelter: @shelter1)
      @review2 = Review.create(title: 'ok shelter',
                              rating: 2,
                              content: 'meh...',
                              image: 'https://images.dog.ceo/breeds/hound-walker/n02089867_454.jpg',
                              user: @user1,
                              shelter: @shelter1)
      @review3 = Review.create(title: 'better shelter',
                              rating: 3,
                              content: 'They treat their pets well.',
                              image: 'https://images.dog.ceo/breeds/hound-walker/n02089867_454.jpg',
                              user: @user1,
                              shelter: @shelter1)
      @review4 = Review.create(title: 'Great shelter',
                              rating: 4,
                              content: "They're radical!",
                              image: 'https://images.dog.ceo/breeds/hound-walker/n02089867_454.jpg',
                              user: @user1,
                              shelter: @shelter1)
      @application1 = Application.create({
                              user: @user1,
                              description: 'I have a great house for a dog',
                              status: 'In Progress'
                              })
      @application2 = Application.create({
                              user: @user2,
                              description: 'Im a great owner',
                              status: 'In Progress'
                              })
      @app1_pet1 = ApplicationPet.create({
                              application_id: @application1.id,
                              pet_id: @pet1.id
                              })
      @app1_pet2 = ApplicationPet.create({
                              application_id: @application1.id,
                              pet_id: @pet2.id
                              })
      @app2_pet1 = ApplicationPet.create({
                              application_id: @application2.id,
                              pet_id: @pet1.id
                              })

    end
    
    it 'can count pets at a shelter' do
      expect(@shelter1.total_pets).to eq(3)
      expect(@shelter2.total_pets).to eq(0)
    end
    it 'can calculate average shelter review rating' do
      expect(@shelter1.average_rating).to eq(3.25)
      expect(@shelter2.average_rating).to eq(nil)
    end
    it 'can count number of applications on file' do
      expect(@shelter1.application_count).to eq(2)
      expect(@shelter2.application_count).to eq(0)
    end
    it 'do things with active record' do
      expect(@shelter1.any_approved_apps?).to eq(true)
      
    end
    
  end
end
