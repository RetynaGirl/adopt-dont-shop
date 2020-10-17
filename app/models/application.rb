class Application < ApplicationRecord
  validates_presence_of :user_id, :status

  belongs_to :user
  has_many :application_pets
  has_many :pets, through: :application_pets
end
