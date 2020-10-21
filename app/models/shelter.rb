class Shelter < ApplicationRecord
  has_many :pets
  has_many :reviews

  validates_presence_of :name, :address, :city, :state, :zip

  def total_pets
    pets.count
  end

  def average_rating
    reviews.average(:rating)
  end

  def application_count
    pets.joins(:application_pets).group(:application_id).pluck(:application_id).count
  end

  def any_pending_or_approved_applications?
    #pets.joins(:application_pets).joins(:applications).where("applications.status IN ('Approved','In Progress')")
    approved_or_pending_apps = pets.joins(:application_pets).joins(:applications).where.not("applications.status= ?","Rejected")
    !approved_pending_apps.empty? #if no apps are pending or approved, then method should return false.
    
  end

end
