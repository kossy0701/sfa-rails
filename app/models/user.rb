require 'csv'

class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  include DeviseTokenAuth::Concerns::User
  extend ActiveHash::Associations::ActiveRecordExtensions

  enum sex: { male: false, female: true }

  belongs_to :tenant
  belongs_to :manager, class_name: 'User', optional: true

  belongs_to_active_hash :prefecture

  has_many :daily_reports, dependent: :destroy
  has_many :schedules, dependent: :destroy

  delegate :prefecture_name, to: :prefecture

  has_one_attached :image

  def full_name
    "#{last_name} #{first_name}"
  end

  def self.import_from_csv(upload_file, tenant)
    users = []
    CSV.foreach(upload_file.tempfile, headers: true) do |row|
      _prefecture_id = Prefecture.find_by(prefecture_name: row[8]).id
      raise NotFoundError unless _prefecture_id
      _administrator = row[7] == '管理者' ? true : false
      _sex = row[6] == '男' ? :male : :female
      user = { last_name: row[0], first_name: row[1], last_name_kana: row[2], first_name_kana: row[3], email: row[4], birthday: row[5], sex: _sex, administrator: _administrator, prefecture_id: row[8], created_at: Time.now, updated_at: Time.now, tenant_id: tenant.id }
      users << user
    end
    insert_all users
  end

  def encoded_image
    "data:image/png;base64,#{Base64.encode64(image.download)}" if image.attached?
  end
end
