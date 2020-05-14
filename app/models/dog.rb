class Dog < ApplicationRecord
  paginates_per 5

  belongs_to :user

  has_many :likes, dependent: :destroy

  has_many_attached :images


  def likes_in_last_hour
    now = Time.now
    likes.where(created_at: (now - 1.hour)..now).count
  end
end
