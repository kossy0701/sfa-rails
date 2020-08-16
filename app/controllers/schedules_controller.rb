class SchedulesController < ApplicationController
  before_action :authenticate_user
  before_action :set_schedule, only: [:show, :update, :destroy]

  def index
    begin
      target_month = Month.parse(params[:target_month])
    rescue => e
      raise BadRequest, code: 'schedule_invalid_format_date_error'
    end
    @schedules = Schedule.where('? >= created_at && created_at > ?', target_month.to_date.to_time, target_month.next.to_date.to_time)
  end

  def show
  end

  def create
    @schedule = Schedule.new(schedule_params)

    if @schedule.save
      render :show, status: :created
    else
      render json: @schedule.errors
    end
  end

  def update
    if @schedule.update(schedule_params)
      render :show, status: :ok, location: @schedule
    else
      render json: @schedule.errors, status: 400
    end
  end

  def destroy
    @schedule.destroy
  end

  private
    def set_schedule
      @schedule = Schedule.find(params[:id])
    end

    def schedule_params
      params.require(:schedule).permit(:user_id, :date, :start_time, :end_time, :subject, :content).merge(user_id: current_user)
    end
end
