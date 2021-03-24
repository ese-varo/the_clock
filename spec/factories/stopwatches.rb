FactoryBot.define do
  factory :stopwatch do
    association :user
    label { Faker::Verb.base } 
  end
end
