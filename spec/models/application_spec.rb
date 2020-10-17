require 'rails_helper'

describe Application, type: :model do
  describe 'validations' do
    it do
      should validate_presence_of :user_id
      should validate_presence_of :status
    end
  end
  describe 'relationships' do
    it do
      should belong_to :user
      should have_many :application_pets
      should have_many(:pets).through(:application_pets)
    end
  end
end
