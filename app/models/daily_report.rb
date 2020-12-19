class DailyReport < ApplicationRecord
  belongs_to :user

  enum status: %i[draft open only_manager]

  validates :problem, length: { maximum: 255 }
  validates :improvement, length: { maximum: 255 }
  validates :consultation, length: { maximum: 255 }

end