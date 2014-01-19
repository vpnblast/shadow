class SessionsController < ApplicationController
  skip_before_action :authorize

  def new
  end

  def create
    admin = Admin.find_by_username(params[:username])
    if admin and admin.authenticate(params[:password])
      session[:id] = admin.id
      redirect_to :controller => 'home', :action => 'index'
    else
      redirect_to login_url, alert : "Invalid user/password combination"
    end
  end

  def destroy
    session[:id] = nil
    redirect_to login_url
  end
end
