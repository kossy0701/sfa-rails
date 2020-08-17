require 'csv'

class Admin::UsersController < Admin::Base
  def index
    @users = current_user_tenant.users
  end

  def show
    @user = current_user_tenant.users.find_by(id: params[:id])
    raise NotFound unless @user
  end

  def import
    upload_file = params[:upload_file]
    raise BadRequest, code: 'import_blank_upload_file_error' unless upload_file

    User.import_from_csv(upload_file, current_user_tenant)
    @users = current_user_tenant.users

    render :index
  end
end
