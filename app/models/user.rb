class User < ApplicationRecord
  has_many :reviews

  def best_worst_review
    ordered = self.reviews.order(rating: :desc)
    [ordered.first, ordered.last]
  end
end
