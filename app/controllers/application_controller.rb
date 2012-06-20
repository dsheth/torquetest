class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :authenticate
  after_filter :put_in_pool
  
  private
  
  
  def put_in_pool
    ActiveRecord::Base.clear_active_connections!
  end
  
  def authenticate
    if current_user.nil?
	   logger.info "Current User is nill, redirecting"
	   redirect_to "/"
	end
  end
  
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  
  helper_method :current_user
end
