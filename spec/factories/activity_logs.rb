FactoryBot.define do
  factory :activity_log do
    action { { text: 'ログ', operate: :index} }
    performer { "MyString" }
    performer_type { "MyString" }
    ip_address { "MyString" }
  end
end
