FactoryBot.define do
  factory :timezone do
    association :user
    name { Faker::Name.name }
  end
end
