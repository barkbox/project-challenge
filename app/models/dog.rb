class Dog < ApplicationRecord
  has_many_attached :images
  has_many :likes
  belongs_to :user
end
