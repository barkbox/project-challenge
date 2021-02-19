class Dog < ApplicationRecord
  has_many_attached :images
  belongs_to :user

  alias_method :owner, :user
end
