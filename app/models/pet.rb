class Pet < ApplicationRecord
  belongs_to :shelter, dependent: :destroy

  validates_presence_of :shelter_id
end
