class Admin::AdminController < ApplicationController
  before_filter :check_if_user_admin

  def check_if_user_admin
    if params[:user_role] != 'Admin'
      redirect_to root_path
    end
  end
end
