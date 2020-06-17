FactoryBot.define do
  factory :customer do
    contract_status { 1 }
    name { "MyString" }
    postal_code { "MyString" }
    prefecture_id { 1 }
    city { "MyString" }
    address1 { "MyString" }
    address2 { "MyString" }
  end
end
