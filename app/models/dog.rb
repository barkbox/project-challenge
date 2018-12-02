class Dog < ApplicationRecord
  has_many_attached :images
  belongs_to :user
  acts_as_votable
end
