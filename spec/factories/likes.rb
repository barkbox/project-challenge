FactoryBot.define do
  factory :like do
    user { create :user }
    dog { create :dog }
  end
end
