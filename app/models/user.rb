class User < ApplicationRecord
  has_many :reviews

  def review_average
    self.reviews.average(:rating)
  end
end
