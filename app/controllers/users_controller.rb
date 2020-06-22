class UsersController < ApplicationController
  before_action :authenticate_user!

  def show
    @user =
      if current_user.administrator
        current_user_tenant.users.find_by(id: params[:id])
      else
        current_user
      end
    raise NotFound unless @user
  end
end
