class User < ApplicationRecord
  has_many :reviews

  def highlighted_reviews
    ordered = self.reviews.order(rating: :desc)
    if self.reviews.size == 0
      return nil
    elsif self.reviews.size == 1
      return [self.reviews]
    else
      best_review = ordered.first
      worst_review = ordered.last
      return [best_review, worst_review]
    end
  end
end
