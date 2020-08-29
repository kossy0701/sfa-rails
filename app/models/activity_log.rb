require 'csv'

class ActivityLog < ApplicationRecord
  class UnknownOperationError < StandardError; end

  belongs_to :tenant

  OPERATE_STR = {
    index: '参照',
    create: '作成',
    update: '更新',
    delete: '削除',
    download: 'ダウンロード',
    upload: 'アップロード',
    search: '検索',
  }.freeze

  serialize :action

  def formatted_created_at
    created_at.localtime.strftime('%Y年%m月%d日 %H:%M:%S')
  end

  def log_str
    "#{formatted_created_at} #{performer} さんが #{action[:text]}を#{action[:operate]}しました。"
  end

  def self.operate_str(params)
    str = OPERATE_STR[params[:action].to_sym]

    raise UnknownOperationError unless str

    str
  end

  def self.generate_csv(current_tenant)
    CSV.generate(headers: true) do |csv|
      csv << ['日時', 'アクション', '動作', '名前']
      curent_tenant.activity_logs.each do |log|
        csv << [
          log.formatted_created_at,
          log.action[:text],
          log.action[:operate],
          log.performer
        ]
      end
    end
  end
end
