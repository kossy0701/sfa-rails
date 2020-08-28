class CustomersController < ApplicationController
  before_action :authenticate_user!
  before_action :ip_restriction!
  before_action :set_customer, only: %i[show update destroy]

  def index
    @customers = current_user_tenant.customers
  end

  def show; end

  def create
    @customer = current_user_tenant.customers.new(customer_params)

    if @customer.save
      render :show, status: :created
    else
      render json: { errors: @customer.errors }, status: 400
    end
  end

  def download
    respond_to do |format|
      format.all { send_data Customer.generate_csv }
    end
  end

  def download_zip
    zip_file = Customer.generate_zip
    respond_to do |format|
      format.all { send_data(File.read(zip_file), type: 'application/zip', filename: '顧客一覧.zip') }
    end
    File.delete(zip_file)
  end

  def generate_zoom_url
    # zoomのURLを生成して返す
    # アクティビティのログを残す

    render json: { zoom_url: ZoomClient.generate_url(params.permit(:topic, :duration, :agenda)) }
  end

  private

  def set_customer
    @customer = current_user_tenant.customers.find_by(id: params[:id])
    raise NotFound unless @customer
  end

  def customer_params
    params.permit(:contract_status, :name, :postal_code, :prefecture_id, :city, :address1, :address2)
  end
end
