FactoryBot.define do
  factory :user do
    username { Faker::Internet.username(specifier: 3..20, separators: %w(_)) }
    email { Faker::Internet.email }
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
  end
end
