class Dog < ApplicationRecord
  has_many_attached :images

  self.per_page = 5
end
