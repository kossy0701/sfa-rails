FactoryBot.define do
  factory :tenant do
    name { "MyString" }
    postal_code { "MyString" }
    prefecture_id { 1 }
    city { "MyString" }
    address1 { "MyString" }
    address2 { "MyString" }
  end
end
