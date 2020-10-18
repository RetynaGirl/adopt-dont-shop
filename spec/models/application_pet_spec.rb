require 'rails_helper'

describe ApplicationPet, type: :model do
  describe 'relationships' do
    it {should belong_to :application}
    it {should belong_to :pet}
  end
  # describe 'validations' do
  #   it {should validate_uniqueness_of(:pet_id).scoped_to(:application_id)} 
  # end
end
