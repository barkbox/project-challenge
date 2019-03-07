# == Schema Information
#
# Table name: dogs
#
#  id            :integer          not null, primary key
#  name          :string
#  birthday      :datetime
#  adoption_date :datetime
#  description   :text
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  owner_id      :integer
#

class Dog < ApplicationRecord
  has_many_attached :images

  self.per_page = 5

  belongs_to :owner,
    primary_key: :id,
    foreign_key: :owner_id,
    class_name: 'User'

end
