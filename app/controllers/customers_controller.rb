class CustomersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_customer, only: [:show, :update, :destroy]

  def index
    @customers = Customer.all
  end

  def show
  end

  def create
    @customer = Customer.new(customer_params)

    if @customer.save
      render :show, status: :created
    else
      render json: @customer.errors
    end
  end

  def update
    if @customer.update(customer_params)
      render :show, status: :ok, location: @customer
    else
      render json: @customer.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @customer.destroy
  end

  private
    def set_customer
      @customer = Customer.find(params[:id])
    end

    def customer_params
      params.permit(:contract_status, :name, :postal_code, :prefecture_id, :city, :address1, :address2)
    end
end
