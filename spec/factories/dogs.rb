FactoryBot.define do
  factory :dog do
    sequence :name do |n|
      "Good Pup #{n}"
    end
    user factory: :user

    after(:build) do |dog|
      dog.images.attach(
        io: File.open(Rails.root.join('spec', 'factories', 'images', 'bowie_toys.jpg')),
        filename: 'bowie_toys.jpeg',
        content_type: 'image/jpeg')
    end
  end
end
