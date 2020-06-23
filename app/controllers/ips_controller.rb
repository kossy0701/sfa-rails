class IpsController < ApplicationController
  before_action :authenticate_user!
  before_action :ip_restriction!
  before_action :set_ip, only: :show

  def index
    raise Forbidden unless current_user.administrator
    @ips = current_user.tenant.ips
  end

  def show
  end

  def create
    raise Forbidden unless current_user.administrator
    @ip = Ip.new(ip_params)

    if @ip.save
      render :show, status: :created
    else
      render json: { errors: @customer.errors }, status: 400
    end
  end

  private

    def set_ip
      raise Forbidden unless current_user.administrator
      @ip = current_user_tenant.ips.find_by(id: params[:id])
      raise NotFound unless @ip
    end

    def ip_params
      params.permit(:content).merge(tenant: current_user.tenant)
    end
end
