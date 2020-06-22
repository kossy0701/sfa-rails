FactoryBot.define do
  factory :customer do
    address = Gimei.address

    contract_status { Customer.contract_statuses.keys.sample }
    name { Faker::Company.name }
    postal_code { "#{sprintf('%03d', rand(1000))}-#{sprintf('%04d', rand(10000))}" }
    prefecture_id { rand(1..48) }
    city { address.city.kanji }
    address1 { "#{address.town.kanji}1-1-1" }
    address2 { ['虎ノ門ヒルズ1111', nil].sample }

    association :tenant, factory: :tenant
  end
end
