require 'rails_helper'

describe Review, type: :model do
  describe 'relationships' do
    it do
      should belong_to :shelter
      should belong_to :user
    end
  end

  describe 'verificaions' do
    it do
      should validate_presence_of :title
      should validate_presence_of :rating
      should validate_presence_of :content
      should validate_presence_of :user_id
      should validate_presence_of :shelter_id
    end
  end
end
