class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  include DeviseTokenAuth::Concerns::User

  belongs_to :tenant
  belongs_to :manager, class_name: 'User', optional: true

  enum sex: { male: 0, female: 1 }
end
