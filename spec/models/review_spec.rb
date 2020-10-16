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
      validate_presence_of :title
      validate_presence_of :rating
      validate_presence_of :content
      validate_presence_of :user_id
      validate_presence_of :shelter_id
    end
  end
end
