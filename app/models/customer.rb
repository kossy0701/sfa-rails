class Customer < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions

  belongs_to_active_hash :prefecture
  belongs_to :tenant

  has_many :contacts, dependent: :destroy

  enum contract_status: [:existing, :prospect, :dormant] # 既存客/見込み客/休眠客

  delegate :prefecture_name, to: :prefecture

  validates :contract_status, presence: true
  validates :name, presence: true, length: { maximum: 255 }
  validates :postal_code, presence: true, format: { with: /\A\d{3}[-]\d{4}\z/ }
  validates :prefecture_id, presence: true, length: { minimum: 0, maximum: 47 }
  validates :city, presence: true
  validates :address1, presence: true
end
