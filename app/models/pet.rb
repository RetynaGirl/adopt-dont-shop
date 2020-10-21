class Pet < ApplicationRecord
  belongs_to :shelter, dependent: :destroy
  has_many :application_pets
  has_many :applications, through: :application_pets

  validates_presence_of :shelter_id
end

def self.approved_applications
  #returns a list of pet names whose applications have been approved
  Pet.joins(:application_pets).joins(:applications).where("applications.status = 'Approved'").group("pets.id").pluck("pets.name")
end
def approved_application?
  #returns true/false if a pet has an approved application
  !applications.where("applications.status = 'Approved'").empty?
end
