require 'rails_helper'

# User Story 6, User Reviews

# As a visitor
# When I visit a User's show page
# Then I see every review this User has written
# Including the review's title, rating, and content

describe 'As a visitor' do
  before(:each) do
    @shelter = Shelter.create(name: 'Bobby',
                             address: '123 halmock st',
                             city: 'dover',
                             state: 'florida',
                             zip: '12345')
    @user = User.create(name: "Jake",
                        address: '1234 1st St',
                        city: 'Denver',
                        state: 'CO',
                        zip: '80213') 
    @review = Review.create(title:"Great shelter",
                            rating: 4,
                            content: "They treat their pets well.",
                            image: 'https://images.dog.ceo/breeds/hound-walker/n02089867_454.jpg',
                            user: @user,
                            shelter: @shelter)
  end
  describe 'when I visit a users show page' do
    it 'I see every review this user has written including review details' do
       visit "users/#{@user.id}"

       within("#review-#{@review.id}") do
        expect(page).to have_content(@review.title)
        expect(page).to have_content(@review.rating)
        expect(page).to have_content(@review.content)
       end
    end
  end
end

