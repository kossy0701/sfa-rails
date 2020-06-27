class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  include DeviseTokenAuth::Concerns::User

  enum sex: { male: false, female: true }

  belongs_to :tenant
  belongs_to :manager, class_name: 'User', optional: true

  has_many :daily_reports, dependent: :destroy

  def full_name
    "#{last_name} #{first_name}"
  end
end
