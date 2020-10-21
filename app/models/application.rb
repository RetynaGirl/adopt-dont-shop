class Application < ApplicationRecord
  validates_presence_of :user_id, :status

  belongs_to :user
  has_many :application_pets
  has_many :pets, through: :application_pets

  def pet_status(pet)
    pet_applications = pet.application_pets.where('status = ?', 'Approved')
    if !pet_applications.empty?

      case pet_applications.first.application.id
      when nil
        ApplicationPet.where('pet_id = ? AND application_id = ?', pet.id, id).first.status
      when id
        'Approved'
      else
        'Approved elsewhere'
      end
    else
      ApplicationPet.where('pet_id = ? AND application_id = ?', pet.id, id).first.status
    end
  end

  def approved?
    # application_pets.where.not(status: 'Approved').empty?
    application_pets.pluck(:status).all? { |pet_status| pet_status == 'Approved' }
  end
end
