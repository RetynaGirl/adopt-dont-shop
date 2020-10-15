require 'rails_helper'

# User Story 9, Shelter Review Creation, Incomplete Form

# As a visitor,
# When I visit the new review page
# And I fail to enter a title, a rating, and/or content in the new shelter review form, but still try to submit the form
# I see a flash message indicating that I need to fill in a title, rating, and content in order to submit a shelter review
# And I'm returned to the new form to create a new review

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

  describe 'When I visit the new review page and dont complete the form' do
    it "I see a flash message for filling in all of the information and am returned to the new form page" do
      visit "/shelters/#{@shelter.id}/reviews/new"

      # Testing no inputs
      click_button('Create Review')

      expect(page).to have_content('Please enter data in all required (*) fields')
      expect(page).to have_current_path("/shelters/#{@shelter.id}/reviews/new")

      # Testing title only
      fill_in('review[title]', with: 'Horrible place')

      click_button('Create Review')

      expect(page).to have_content('Please enter data in all required (*) fields')
      expect(page).to have_current_path("/shelters/#{@shelter.id}/reviews/new")

      # Testing content only
      fill_in('review[content]', with: 'Well, it really sucks to be here')

      click_button('Create Review')

      expect(page).to have_content('Please enter data in all required (*) fields')
      expect(page).to have_current_path("/shelters/#{@shelter.id}/reviews/new")
    end
  end

  describe 'When I visit the page to edit a review and remove things from the form fields' do
    it 'I see a flash message to fill in all the stuff that is required' do
      visit "/reviews/#{@review.id}/edit"

      # Testing no inputs
      fill_in('review[title]', with: '')
      fill_in('review[content]', with: '')

      click_button('Update Review')

      expect(page).to have_content('Please enter data in all required (*) fields')
      expect(page).to have_current_path("/reviews/#{@review.id}/edit")

      # Testing title only
      fill_in('review[title]', with: '')

      click_button('Update Review')

      expect(page).to have_content('Please enter data in all required (*) fields')
      expect(page).to have_current_path("/reviews/#{@review.id}/edit")

      # Testing content only
      fill_in('review[content]', with: '')

      click_button('Update Review')

      expect(page).to have_content('Please enter data in all required (*) fields')
      expect(page).to have_current_path("/reviews/#{@review.id}/edit")
    end
  end
end
