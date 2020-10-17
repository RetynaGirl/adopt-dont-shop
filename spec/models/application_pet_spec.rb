require 'rails_helper'

describe ApplicationPet, type: :model do
  describe 'relationships' do
    it do
      should belong_to :application
      should belong_to :pet
    end
  end
end
