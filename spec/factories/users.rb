FactoryBot.define do
  factory :user do
    sex = User.sexes.keys.sample
    gimei = {male: Gimei.male, female: Gimei.female}[sex.to_sym]

    provider         {'email'}
    uid              { Faker::Internet.safe_email }
    password         { Faker::Internet.password }
    email            { uid }
    sex              { sex }
    last_name        { gimei.last.kanji }
    first_name       { gimei.first.kanji }
    last_name_kana   { gimei.last.katakana }
    first_name_kana  { gimei.first.katakana }
    birthday         { Faker::Date.birthday(min_age: 18, max_age: 65) }
    administrator    { [true, false].sample }
    disable          { false }
    prefecture_id    { rand(1..48) }

    association :tenant, factory: :tenant
  end
end

