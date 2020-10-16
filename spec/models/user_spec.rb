require 'rails_helper'

describe User, type: :model do
  describe 'validations' do
    it do
      validate_presence_of :name
      validate_presence_of :address
      validate_presence_of :city
      validate_presence_of :state
      validate_presence_of :zip
    end
  end

  describe 'relationships' do
    it do
      should have_many :reviews
    end
  end

  describe 'instance methods' do
    it 'can calculate highest and lowest rating reviews' do
      @shelter = Shelter.create(name: "Al",address:"234 south st", city: "boulder", state: 'CO', zip: "80231")
      
      @user = User.create(name: 'Jake',
                          address: '1234 1st St',
                          city: 'Denver',
                          state: 'CO',
                          zip: '80213')
      @review1 = Review.create(title: 'Worst shelter',
                              rating: 1,
                              content: 'bad treatment of animals',
                              image: 'https://images.dog.ceo/breeds/hound-walker/n02089867_454.jpg',
                              user: @user,
                              shelter: @shelter)
      @review2 = Review.create(title: 'ok shelter',
                              rating: 2,
                              content: 'meh...',
                              image: 'https://images.dog.ceo/breeds/hound-walker/n02089867_454.jpg',
                              user: @user,
                              shelter: @shelter)
      @review3 = Review.create(title: 'better shelter',
                              rating: 3,
                              content: 'They treat their pets well.',
                              image: 'https://images.dog.ceo/breeds/hound-walker/n02089867_454.jpg',
                              user: @user,
                              shelter: @shelter)
      @review4 = Review.create(title: 'Great shelter',
                              rating: 4,
                              content: "They're radical!",
                              image: 'https://images.dog.ceo/breeds/hound-walker/n02089867_454.jpg',
                              user: @user,
                              shelter: @shelter)
      

      expect(@user.best_worst_review).to eq ([@review4, @review1])
    end
  end
end
