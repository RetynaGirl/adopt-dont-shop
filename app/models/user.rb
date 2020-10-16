class User < ApplicationRecord
  has_many :reviews

  def highlighted_reviews
    ordered = self.reviews.order(rating: :desc)
    if self.reviews.size < 2
      return nil
    else
      best_review = ordered.first
      worst_review = ordered.last
      return [best_review, worst_review]
    end
  end
end
