class Customer < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :prefecture

  enum contract_status: [:existing, :prospect, :dormant]

  delegate :prefecture_name, to: :prefecture
end
