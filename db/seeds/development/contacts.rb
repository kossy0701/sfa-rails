tenants = Tenant.all

0.upto(30) do |idx|
  tenant = tenants.sample
  users = tenant.users
  customers = tenant.customers

  Contact.create(
    user: users.sample,
    customer: customers.sample,
    contacted_at: Faker::Date.between(from: '2020-04-01', to: '2021-03-31'),
    way: Contact.ways.keys.sample,
    purpose: Contact.purposes.keys.sample,
    subject: Faker::Lorem.sentence,
    content: Faker::Lorem.sentence,
    target: Contact.targets.keys.sample
  )
end