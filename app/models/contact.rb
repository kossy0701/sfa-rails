class Contact < ApplicationRecord
  belongs_to :user
  belongs_to :customer

  enum way: [:phone, :email, :appoint]
  enum purpose: [:proposal, :contract, :other]
  enum target: [:president, :manager, :staff]

  validates :contacted_at, presence: true
  validates :way, presence: true
  validates :purpose, presence: true
  validates :subject, presence: true, length: { maximum: 255 }
  validates :content, presence: true
  validates :target, presence: true
end
