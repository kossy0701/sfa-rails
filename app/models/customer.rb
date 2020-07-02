require 'csv'
require 'zip'

class Customer < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions

  CSV_HEADERS = %w[ID 属性 名称 郵便番号 都道府県 市町村 住所1 住所2]

  belongs_to_active_hash :prefecture
  belongs_to :tenant

  has_many :contacts, dependent: :destroy

  enum contract_status: %i[existing prospect dormant]

  delegate :prefecture_name, to: :prefecture

  validates :contract_status, presence: true
  validates :name, presence: true, length: { maximum: 255 }
  validates :postal_code, presence: true, format: { with: /\A\d{3}[-]\d{4}\z/ }
  validates :prefecture_id, presence: true, length: { minimum: 0, maximum: 47 }
  validates :city, presence: true
  validates :address1, presence: true

  def self.generate_csv(customers)
    CSV.generate(headers: true) do |csv|
      csv << CSV_HEADERS
      customers.each do |customer|
        csv << [
          customer.id,
          { existing: '既存顧客', prospect: '見込み顧客', dormant: '休眠顧客' }[customer.contract_status.to_sym],
          customer.name,
          customer.postal_code,
          customer.prefecture.prefecture_name,
          customer.city,
          customer.address1,
          customer.address2
        ]
      end
    end
  end

  def self.generate_zip(customers)
    zipfile_name = "#{Rails.root}/tmp/顧客一覧.zip"
    Zip::File.open(zipfile_name, Zip::File::CREATE) do |zipfile|
      dir_path = Pathname.new(Dir.mktmpdir + '/顧客一覧.csv')
      CSV.open(dir_path, 'wb', headers: true) do |csv|
        csv << CSV_HEADERS
        customers.each do |customer|
          csv << [
            customer.id,
            { existing: '既存顧客', prospect: '見込み顧客', dormant: '休眠顧客' }[customer.contract_status.to_sym],
            customer.name,
            customer.postal_code,
            customer.prefecture.prefecture_name,
            customer.city,
            customer.address1,
            customer.address2
          ]
        end
      end
      zipfile.add dir_path.basename, dir_path
    end
    zipfile_name
  end
end
