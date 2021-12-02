class Client::ClientController < ApplicationController
  before_filter :set_customer_session

  def set_customer_session
    @current_user = Customer.first
    @current_user_id = session[:current_customer_id] = @current_user.id
  end
end
