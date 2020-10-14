require 'rails_helper'
# User Story 5, Shelter Review Creation

# As a visitor,
# When I visit a shelter's show page
# I see a link to add a new review for this shelter.
# When I click on this link, I am taken to a new review path
# On this new page, I see a form where I must enter:
# - title
# - rating
# - content
# - the name of a user that exists in the database
# I also see a field where I can enter an optional image (web address)
# When the form is submitted, I should return to that shelter's show page
# and I can see my new review

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
  end
  describe 'When I visit a shelters show page' do
    it 'I see a link to add a new review for this shelter' do
      visit "/shelters/#{@shelter.id}"

      expect(page).to have_link('Add Review')

      click_link('Add Review')

      expect(page).to have_current_path("/shelters/#{@shelter.id}/reviews/new")
    end
  end

  describe 'When I am on the new review page' do
    it 'I see fields to enter review information' do
      visit "/shelters/#{@shelter.id}/reviews/new"

      fill_in('review[title]', with: 'Pretty Cool Shelter')
      select(4, from: 'review[rating]')
      fill_in('review[content]', with: "It's pretty good, they treat their animals well and have good staff")
      select(@user.name, from: 'review[user_id]')
      fill_in('review[image]', with: 'https://images.dog.ceo/breeds/komondor/n02105505_1024.jpg')

      click_button('Create Review')

      expect(current_path).to eq("/shelters/#{@shelter.id}")
    end
  end
end
