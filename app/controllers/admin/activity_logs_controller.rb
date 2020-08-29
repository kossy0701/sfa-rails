class Admin::ActivityLogsController < Admin::Base
  after_action :create_activity_log

  def index
    @activity_logs = ActivityLog.all
  end

  private

  def create_activity_log
    ActivityLog.create!(action: { text: 'アクティビティログ', operate: ActivityLog.operate_str(params.permit(:action)) }, performer: current_user.full_name, performer_type: current_user.class.to_s, ip_address: request.remote_ip)
  end

end
