FactoryBot.define do
  factory :lap do
    association :stopwatch
    time { Faker::Number.number(digits: 4) }
    difference { Faker::Number.number(digits: 4) }
  end
end
