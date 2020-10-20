require 'rails_helper'

describe Application, type: :model do
  describe 'validations' do
    it do
      should validate_presence_of :user_id
      should validate_presence_of :status
    end
  end

  describe 'relationships' do
    it do
      should belong_to :user
      should have_many :application_pets
      should have_many(:pets).through(:application_pets)
    end
  end

  describe 'instance methods' do
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
    end
    it '#pet_status' do
      
      ApplicationPet.create(application: @application, pet: @pet1)
      ApplicationPet.create(application: @application, pet: @pet2, status: 'Approved')

      expect(@application.pet_status(@pet1)).to eq(nil)

      expect(@application.pet_status(@pet2)).to eq('Approved')
    end
    it '#all_pets_approved' do
     
      app1_pet1 = ApplicationPet.create(application: @application, pet: @pet1)
      app1_pet2 = ApplicationPet.create(application: @application, pet: @pet2, status: 'Approved')
      
      expect(@application.all_pets_approved).to eq(false)
      
      app1_pet1 = ApplicationPet.update(status: 'Approved')
      expect(@application.all_pets_approved).to eq(true)
      
    end
  end
end
