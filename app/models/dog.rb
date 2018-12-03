class Dog < ApplicationRecord
  has_many_attached :images
  belongs_to :user, optional: true
  attr_accessor :image_path
end
