FactoryBot.define do
  factory :stopwatch do
    association :user
    label { Faker::Verb.base } 

    # after(:build) do |stopwatch|
    #   5.times do
    #     stopwatch.laps << FactoryBot.build(:lap, stopwatch: stopwatch)
    #   end
    # end
  end
end
