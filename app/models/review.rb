class Review < ApplicationRecord
  belongs_to :user
  belongs_to :shelter

  validates_presence_of :title, :rating, :content, :user_id, :shelter_id
end
