require 'rails_helper'

describe Pet, type: :model do
  describe 'validations' do
    it do
      validate_presence_of :name
      validate_presence_of :image
      validate_presence_of :age
      validate_presence_of :sex
      validate_presence_of :shelter_id
    end
  end

  describe 'relationships' do
    it { should belong_to :shelter }
  end
end
