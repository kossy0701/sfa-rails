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

  private

  def set_customer
    @customer = current_user_tenant.customers.find_by(id: params[:id])
    raise NotFound unless @customer
  end

  def customer_params
    params.permit(:contract_status, :name, :postal_code, :prefecture_id, :city, :address1, :address2)
  end
end
