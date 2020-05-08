class Dog < ApplicationRecord
  # ActiveStorage
  has_many_attached :images

  # Default Pagination Rule (will_paginate)
  self.per_page = 5
end
