class TenantsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_tenant, only: %i[show update destroy]

  def index
    @tenants = Tenant.all
  end

  def show; end

  def create
    @tenant = Tenant.new(tenant_params)

    if @tenant.save
      render :show, status: :created, location: @tenant
    else
      render json: @tenant.errors, status: :unprocessable_entity
    end
  end

  def update
    if @tenant.update(tenant_params)
      render :show, status: :ok, location: @tenant
    else
      render json: @tenant.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @tenant.destroy
  end

  private

  def set_tenant
    @tenant = Tenant.find(params[:id])
  end

  def tenant_params
    params.require(:tenant).permit(:name, :postal_code, :prefecture_id, :city, :address1, :address2)
  end
end
