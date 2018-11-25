FactoryBot.define do
  factory :user do
    sequence :name do |n|
      "User #{n}"
    end
    sequence :email do |n|
      "email#{n}@email.com"
    end
    password  'password'
    password_confirmation 'password'
  end
end