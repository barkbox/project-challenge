require 'securerandom'

FactoryBot.define do
  factory :user do
    sequence(:email) {|n| "dogs-love-#{SecureRandom.hex}@treats.co.uk"}
    password {"ilovedogs"}
  end
end
