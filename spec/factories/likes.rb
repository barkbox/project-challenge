FactoryBot.define do
  factory :like do
    like_count { "MyString" }
    user { nil }
    dog { nil }
  end
end
