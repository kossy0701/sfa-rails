class ContactsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_contact, only: %i[show update destroy]

  def index
    @customer = current_user_tenant.customers.find_by(id: params[:customer_id])
    raise NotFound unless @customer

    @contacts = current_user_tenant.customers.find_by(id: params[:customer_id]).contacts
  end

  def show; end

  def create
    @customer = current_user_tenant.customers.find_by(id: params[:customer_id])
    raise NotFound unless @customer

    @contact = @customer.contacts.new(contact_params)

    if @contact.save
      render :show, status: :created
    else
      render json: { errors: @contact.errors }, status: 400
    end
  end

  private

  def set_contact
    @customer = current_user_tenant.customers.find_by(id: params[:customer_id])
    raise NotFound unless @customer

    @contact = @customer.contacts.find_by(id: params[:id])
    raise NotFound unless @contact
  end

  def contact_params
    params.permit(:contacted_at, :way, :purpose, :subject, :content, :target).merge(user: current_user)
  end
end
