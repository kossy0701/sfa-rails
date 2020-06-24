FactoryBot.define do
  factory :daily_report do
    problem      { Faker::Lorem.sentence }
    improvement  { Faker::Lorem.sentence }
    consultation { Faker::Lorem.sentence }

    association :user, factory: :user
  end
end
