class Dog < ApplicationRecord
  paginates_per 5
  has_many_attached :images
end
