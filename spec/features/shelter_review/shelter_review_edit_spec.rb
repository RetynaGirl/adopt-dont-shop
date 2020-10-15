require 'rails_helper'

# User Story 7, Edit a Shelter Review

# As a visitor,
# When I visit a shelter's show page
# I see a link to edit the shelter review next to each review.
# When I click on this link, I am taken to an edit shelter review path
# On this new page, I see a form that includes that review's pre populated data:
# - title
# - rating
# - content
# - image
# - the name of the user that wrote the review
# I can update any of these fields and submit the form.
# When the form is submitted, I should return to that shelter's show page
# And I can see my updated review

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
  end
  describe 'When I visit a shelters show page' do
    it 'I see a link to edit the shelter review' do
      visit "/shelters/#{@shelter.id}"

      within("#review-#{@review.id}") do
        click_link('Update Review')
      end

      expect(page).to have_current_path("/reviews/#{@review.id}/edit")
    end
  end

  describe 'When I visit a review edit page' do
    it 'I see a form to edit the reviews information' do
      visit "/reviews/#{@review.id}/edit"

      fill_in('review[title]', with: 'Horrible Shelter')
      select(1, from: 'review[rating]')
      fill_in('review[content]', with: 'This place really sucks, its horrible')
      fill_in('review[image]', with: '')
      select('Bob', from: 'review[user_id]')

      click_button('Update Review')

      expect(page).to have_current_path("/shelters/#{@shelter.id}")

      within("#review-#{@review.id}") do
        expect(page).to have_content('Horrible Shelter')
        expect(page).to have_content('1')
        expect(page).to have_content('This place really sucks, its horrible')
        expect(page).to have_content('Bob')
        expect(page).to_not have_selector("img")
      end
    end
  end
end
