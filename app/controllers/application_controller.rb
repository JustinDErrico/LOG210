class ApplicationController < ActionController::Base
  protect_from_forgery

  helper_method :current_user
  before_filter :require_login
  private

#################################################################################
#Source:
#http://stackoverflow.com/questions/5056451/redirect-to-login-page-if-user-not-logged-in
#################################################################################
  def require_login
    unless current_user
      #redirect_to login_path
    end
  end
  def current_user
    @current_user ||= Client.find(session[:client_id]) if session[:client_id]
  end



end
