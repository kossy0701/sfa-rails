3.times do
  Tenant.create!(
    name: Faker::Company.name,
    postal_code: "#{sprintf('%03d', rand(1000))}-#{sprintf('%04d', rand(10000))}",
    prefecture_id: rand(1..48),
    city: '中央区',
    address1: "1-#{rand(1..8)}-#{rand(1..16)}",
    address2: ['ヒカリエ', '丸ビル', '虎ノ門ヒルズ', '森ビル', nil].sample
  )
end