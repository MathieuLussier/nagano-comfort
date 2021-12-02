class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :set_user_role_in_params, :set_action_instance_variable, :set_pages_limit_params

  @user_role = 'User'

  def set_user_role_in_params
    unless params[:user_role].present?
      params[:user_role] = 'User'
    end

    @user_role = params[:user_role]
  end

  def set_action_instance_variable
    @action = params[:action]
    @controller = params[:controller]
  end

  def set_pages_limit_params
    params[:pages] ||= 0
    params[:limit] ||= 10
  end

  def default_url_options(options = {})
    options.merge({ user_role: params[:user_role] })
  end
end
