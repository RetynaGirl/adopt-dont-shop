class Application < ApplicationRecord
  validates_presence_of :user_id, :status

  belongs_to :user
  has_many :application_pets
  has_many :pets, through: :application_pets

  def pet_status(pet)
    ApplicationPet.where('pet_id = ? AND application_id = ?', pet.id, id).first.status
  end

  def pet_approvals
    return :approved if pets.pluck(:status).all? {|pet_status| pet_status == "Approved"}
    return :rejected if pets.pluck(:status).any? {|pet_status| pet_status == "Rejected"}
  end
end
