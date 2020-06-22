class IpsController < ApplicationController
  before_action :authenticate_user!
  before_action :ip_restriction
  before_action :set_ip, only: [:show, :update, :destroy]

  def index
    @ips = current_user.tenant.ips
  end

  def show
  end

  def create
    @ip = Ip.new(ip_params)

    if @ip.save
      render :show, status: :created, location: @ip
    else
      render json: @ip.errors, status: :unprocessable_entity
    end
  end

  def update
    if @ip.update(ip_params)
      render :show, status: :ok, location: @ip
    else
      render json: @ip.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @ip.destroy
  end

  private

    def set_ip
      @ip = Ip.find(params[:id])
    end

    def ip_params
      params.permit(:content)
    end
end
