FactoryBot.define do
  factory :alarm do 
    association :user
    label { Faker::Name.name }
    time { Faker::Time.between_dates(from: Date.today, to: Date.today + 2, period: :all)}
    days { ['Monday', 'Wednesdey', 'Friday'] }
  end
end
