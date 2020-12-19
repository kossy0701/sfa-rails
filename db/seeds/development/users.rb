tenants = Tenant.all

0.upto(5) do |idx|
  gimei = Gimei.name
  sex = [:male, :female].sample
  gimei =
    if sex == :male
      Gimei.male
    else
      Gimei.female
    end
  User.create(
    tenant: tenants.sample,
    last_name: gimei.last.kanji,
    first_name: gimei.first.kanji,
    last_name_kana: gimei.last.katakana,
    first_name_kana: gimei.first.katakana,
    sex: sex,
    birthday: Faker::Date.birthday,
    email: "test+#{idx}@gmail.com",
    password: 'test1234',
    administrator: false,
    prefecture_id: rand(1..48)
  )
end
