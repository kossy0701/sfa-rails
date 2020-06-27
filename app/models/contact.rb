class Contact < ApplicationRecord
  belongs_to :user
  belongs_to :customer

  enum way: %i[phone email appoint]
  enum purpose: %i[proposal contract other]
  enum target: %i[president manager staff]

  validates :contacted_at, presence: true
  validates :way, presence: true
  validates :purpose, presence: true
  validates :subject, presence: true, length: { maximum: 255 }
  validates :content, presence: true
  validates :target, presence: true
end
