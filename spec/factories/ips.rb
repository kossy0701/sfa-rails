require 'ipaddr'

FactoryBot.define do
  factory :ip do
    content { IPAddr.new(rand(2**32),Socket::AF_INET) }

    association :tenant, factory: :tenant
  end
end
