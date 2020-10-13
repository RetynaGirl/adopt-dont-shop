require 'rails_helper'

describe User, type: :model do
  describe 'validations' do
    it do
      validate_presence_of :name
      validate_presence_of :address
      validate_presence_of :city
      validate_presence_of :state
      validate_presence_of :zip
    end
  end

  describe 'relationships' do
    it do
      should have_many :reviews
    end
  end
end
