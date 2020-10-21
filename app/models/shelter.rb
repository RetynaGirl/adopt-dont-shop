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
end
