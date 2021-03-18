FactoryBot.define do
  factory :user do
    email { Faker::Internet.email(domain: "example.com") }
    name { Faker::Name.name }
    password { Faker::Internet.password(min_length: 6) }
  end
end
