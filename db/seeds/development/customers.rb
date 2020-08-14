tenant = Tenant.create!(
  name: Faker::Company.name,
  postal_code: "#{sprintf('%03d', rand(1000))}-#{sprintf('%04d', rand(10000))}",
  prefecture_id: rand(1..48),
  city: '中央区',
  address1: '1-13-1',
  address2: ['虎ノ門ヒルズ', '森ビル', nil].sample
)

0.upto(9) do |idx|
  Customer.create(
    tenant: tenant,
    contract_status: :prospect,
    name: Faker::Company.name,
    postal_code: "#{sprintf('%03d', rand(1000))}-#{sprintf('%04d', rand(10000))}",
    prefecture_id: rand(1..48),
    city: '中央区',
    address1: '1-13-1',
    address2: ['虎ノ門ヒルズ', '森ビル', nil].sample
  )
end
