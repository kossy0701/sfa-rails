class Tenant < ApplicationRecord
  has_many :ips, dependent: :destroy
  has_many :customers, dependent: :destroy
  has_many :users, dependent: :destroy
  has_many :activity_logs, dependent: :destroy
end
