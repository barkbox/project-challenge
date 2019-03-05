class Dog < ApplicationRecord
  has_many_attached :images
  
  belongs_to :owner,
  class_name: :User,
  foreign_key: :user_id,
  optional: true

end
