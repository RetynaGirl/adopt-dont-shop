# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
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
      @application = Application.create({
                        user: @user,
                        description: "I have a great house for a dog",
                        status: "In Progress"
      })

      ApplicationPet.create(application: @application, pet: @pet1)
      ApplicationPet.create(application: @application, pet: @pet2)
