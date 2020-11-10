class Dog < ApplicationRecord
  has_many_attached :images
  belongs_to :user
  has_many :likes, dependent: :destroy
end
