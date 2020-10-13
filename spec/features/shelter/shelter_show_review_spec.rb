# User Story 4, Shelter Reviews

# As a visitor,
# When I visit a shelter's show page,
# I see a list of reviews for that shelter
# Each review will have:
# - title
# - rating
# - content
# - an optional picture
# - the name of the user that wrote the review

describe 'As a visitor' do
  describe "When I visit '/shelters/:id'" do
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
                              image: 'https://images.dog.ceo/breeds/hound-walker/n02089867_454.jpg'
                              user: @user,
                              shelter: @shelter)
      
    end
    it "I see a list of reviews for that shelter" do

      visit "/shelters/#{@shelter.id}"

      expect(page).to have_content(@review.title)
      expect(page).to have_content(@review.user.name)
      expect(page).to have_content(@review.rating)
      expect(page).to have_xpath("//img[@src='#{@review.image}']")
      expect(page).to have_content(@review.content)
    end
  end
end