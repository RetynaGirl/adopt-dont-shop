require 'rails_helper'

# User Story 13, User Review Average Rating

# As a visitor
# When I visit a User's show page
# Then I see the average rating of all of their reviews

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
    @review = Review.create(title: 'Great shelter',
                            rating: 4,
                            content: 'They treat their pets well.',
                            image: 'https://images.dog.ceo/breeds/hound-walker/n02089867_454.jpg',
                            user: @user,
                            shelter: @shelter)
  end

  describe 'When I visit a user show page' do
    it 'I see the average rating of all of their reviews' do
      visit "/users/#{@user.id}"
      within('.review-block') do
        expect(page).to have_content(@user.review_average)
      end
    end
  end
end
