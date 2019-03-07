# == Schema Information
#
# Table name: likes
#
#  id         :integer          not null, primary key
#  dog_id     :integer          not null
#  liker_id   :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Like < ApplicationRecord

  belongs_to :liker,
    primary_key: :id,
    foreign_key: :liker_id,
    class_name: 'User'

  belongs_to :dog,
    primary_key: :id,
    foreign_key: :dog_id,
    class_name: 'Dog'


end
