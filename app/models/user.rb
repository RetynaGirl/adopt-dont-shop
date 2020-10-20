class User < ApplicationRecord
  has_many :reviews
  has_many :applications

  def review_average
    reviews.average(:rating)
  end

  def highlighted_reviews
    ordered = reviews.order(rating: :desc)
    if reviews.size < 2
      nil
    else
      best_review = ordered.first
      worst_review = ordered.last
      [best_review, worst_review]
    end
  end
end
