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

FactoryBot.define do
  factory :dog do
    sequence :name do |n|
      "Good Pup #{n}"
    end
    after(:build) do |dog|
      dog.images.attach(
        io: File.open(Rails.root.join('spec', 'factories', 'images', 'bowie_toys.jpg')),
        filename: 'bowie_toys.jpeg',
        content_type: 'image/jpeg')
    end
  end
end
