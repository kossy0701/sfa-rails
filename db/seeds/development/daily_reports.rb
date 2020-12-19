users = User.all

0.upto(30) do |idx|
  DailyReport.create(
    user: users.sample,
    problem: Faker::Lorem.sentence,
    improvement: Faker::Lorem.sentence,
    consultation: Faker::Lorem.sentence,
    status: DailyReport.statuses.keys.sample
  )
end