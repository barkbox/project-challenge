class Like < ApplicationRecord
  belongs_to :dog, counter_cache: true
  belongs_to :user
end
