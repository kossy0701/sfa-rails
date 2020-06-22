FactoryBot.define do
  factory :contact do
    contacted_at { Date.today }
    way          { Contact.ways.keys.sample }
    purpose      { Contact.purposes.keys.sample }
    subject      { Faker::Lorem.sentence }
    content      { Faker::Lorem.sentence }
    target       { Contact.targets.keys.sample }

    association :user, factory: :user
    association :customer, factory: :customer
  end
end
