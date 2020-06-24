class DailyReportsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_daily_report, only: [:show, :update, :destroy]

  def index
    if current_user.administrator
      @user = current_user_tenant.users.find_by(id: params[:user_id])
      raise NotFound unless @user
      @daily_reports = @user.daily_reports
    else
      @daily_reports = current_user.daily_reports
    end
  end

  def show
  end

  def create
    @daily_report = DailyReport.new(daily_report_params)

    if @daily_report.save
      render :show, status: :created
    else
      render json: { errors: @contact.errors }, status: 400
    end
  end

  private
    def set_daily_report
      @user =
        if current_user.administrator
          current_user_tenant.users.find_by(id: params[:user_id])
        else
          current_user
        end
      raise NotFound unless @user

      @daily_report = @user.daily_reports.find_by(id: params[:id])
      raise NotFound unless @daily_report
    end

    def daily_report_params
      params.permit(:problem, :improvement, :consultation).merge(user: current_user)
    end
end
