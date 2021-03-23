FactoryBot.define do
  factory :alarm do 
    association :user
    label { Faker::Name.name }
    time { Faker::Time.between_dates(from: Date.today, to: Date.today + 2, period: :all).strftime('%H:%M')}
    days { ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday'] }
  end
end
