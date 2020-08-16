FactoryBot.define do
  factory :schedule do
    user { nil }
    date { "2020-08-15" }
    start_time { "2020-08-15 22:00:24" }
    end_time { "2020-08-15 22:00:24" }
    subject { "MyString" }
    content { "MyText" }
  end
end
