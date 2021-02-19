class Dog < ApplicationRecord
  has_many_attached :images
  belongs_to :user

  alias_method :owner, :user

  validates :name, presence: true
  validates :owner, presence: true
  validates :description, presence: true
  validates :images, presence: true

  acts_as_votable
end
