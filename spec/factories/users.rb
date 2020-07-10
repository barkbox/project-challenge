FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "email_#{n}_#{Random.new.rand(10000000000)}@email.com" }
    password "P@ssw0rd519!"
  end
end
