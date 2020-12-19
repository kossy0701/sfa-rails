users = User.all
START_TIMES = ['09:00', '10:00', '11:00', '12:00', '13:00', '14:00', '15:00', '16:00', '17:00', '18:00']

0.upto(30) do
  start_time = START_TIMES.sample
  end_time = (start_time.to_time + rand(1..3).hour).strftime('%R')

  Schedule.create!(
    user: users.sample,
    date: Faker::Date.between(from: '2020-04-01', to: '2021-03-31'),
    start_time: start_time,
    end_time: end_time,
    subject: ['appoint', 'travel_time', 'lunch_meeting', 'meeting'].sample,
    content: Faker::Lorem.sentence
  )
end
