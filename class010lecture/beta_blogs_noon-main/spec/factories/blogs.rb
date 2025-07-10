FactoryBot.define do
  factory :blog do
    title { Faker::Lorem.sentence }
    content { Faker::Lorem.paragraph }
    user
  end
end
