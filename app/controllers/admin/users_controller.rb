class Admin::UsersController < Admin::Base
  def index
    @users = current_user_tenant.users
  end

  def show
    @user = current_user_tenant.users.find_by(id: params[:id])
    raise NotFound unless @user
  end
end
