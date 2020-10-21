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
    end
    it 'can count pets at a shelter' do
      expect(@shelter1.total_pets).to eq(3)
      expect(@shelter2.total_pets).to eq(0)
    end

  end
end
