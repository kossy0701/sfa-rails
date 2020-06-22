class Admin::Base < ApplicationController
  before_action :authenticate_admin!

  private

    def authenticate_admin!
      raise Forbidden unless current_user && current_user.administrator?
    end
end
