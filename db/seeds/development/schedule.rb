gimei = Gimei.name
sex = [:male, :female].sample
gimei =
  if sex == :male
    Gimei.male
  else
    Gimei.female
  end

user = User.create!(
  tenant: Tenant.first,
  last_name: gimei.last.kanji,
  first_name: gimei.first.kanji,
  last_name_kana: gimei.last.katakana,
  first_name_kana: gimei.first.katakana,
  sex: sex,
  birthday: Faker::Date.birthday,
  email: "test+#{SecureRandom.hex(4)}@gmail.com",
  password: 'test1234',
  administrator: false,
  prefecture_id: rand(1..48)
)

Schedule.create!(
  user: user,
  date: Date.today.in(7.days),
  start_time: '12:00',
  end_time: '13:00',
  subject: 'test',
  content: 'lorem ipsum...'
)
