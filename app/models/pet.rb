class Pet < ApplicationRecord
  belongs_to :shelter, dependent: :destroy
  has_many :application_pets
  has_many :applications, through: :application_pets

  validates_presence_of :shelter_id
end
