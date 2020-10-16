class User < ApplicationRecord
  has_many :reviews

  def highlighted_reviews
    ordered = self.reviews.order(rating: :desc)
    [ordered.first, ordered.last]
  end
end
