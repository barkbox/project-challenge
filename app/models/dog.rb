class Dog < ApplicationRecord
  has_many_attached :images
  has_many :likes
  belongs_to :user

  # TODO: Still needs ordering by recent likes (in the last hour)
  scope :recent_likes, -> { order("likes_count DESC") }
end
