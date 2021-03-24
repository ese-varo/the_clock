FactoryBot.define do
  factory :user do
    email { Faker::Internet.email(domain: "example.com") }
    name { Faker::Name.name }
    password { Faker::Internet.password(min_length: 6) }
  end

  factory :user_devise do
    email { Faker::Internet.email(domain: "example.com") }
    display_name { Faker::Name.name }
    password { Faker::Internet.password(min_length: 6) }
    password_confirmation { password }
  end
end
