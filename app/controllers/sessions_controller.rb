

class SessionsController < ApplicationController

include SessionsHelper

  skip_before_filter :authorize

  def show_login_form
  end

  def log_in
    if authenticate_user(params[:email], params[:password])
      session[:admin] = true
      redirect_to pages_path, :notice => "Logged in"
    else
      redirect_to login_url, :notice => "Wrong credentials"
    end
  end

  def log_out
    session[:admin] = false
    render :nothing => true
  end

end
