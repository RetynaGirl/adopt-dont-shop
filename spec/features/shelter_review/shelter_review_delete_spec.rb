require 'rails_helper'

# User Story 8, Delete a Shelter Review

# As a visitor,
# When I visit a shelter's show page,
# Then I see a link next to each shelter review to delete the review.
# When I click this link
# Then I am returned to the shelter's show page
# And I no longer see that shelter review
describe 'As a visitor' do
  describe 'When I visit a /shelter/:id' do
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
    @user2 = User.create(name: 'Bob',
                        address: '1234 1st St',
                        city: 'omaha',
                        state: 'nebraska',
                        zip: '80213')
    @review = Review.create(title: 'Great shelter',
                            rating: 4,
                            content: 'They treat their pets well.',
                            image: 'https://images.dog.ceo/breeds/hound-walker/n02089867_454.jpg',
                            user: @user,
                            shelter: @shelter)
    @review_id = @review.id
    end
    it "i see a link to delete a review" do
      visit "/shelters/#{@shelter.id}"

      within("#review-#{@review.id}") do
        click_button("Delete")
      end
      expect(current_path).to eq("/shelters/#{@shelter.id}")
      
      expect(page).to_not have_selector("#review-#{@review_id}")
    end
  end
end
