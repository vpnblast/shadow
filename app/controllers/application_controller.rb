class ApplicationController < ActionController::Base
  before_action :authorize
  protect_from_forgery with : :exception

  protected

  def authorize
    unless Admin.find_by_id(session[:id])
      redirect_to login_url, notice : "Please log in"
    end
  end

end
