class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def is_logged_in
    if session[:current_user] == nil
      flash[:notice] = 'You need to login to continue...'
      redirect_to :action=>'login', :controller=>'authentication'
    end
  end

  private
  def current_user
    unless session[:current_user].nil?
      @current_user = User.find(session[:current_user])
      return @current_user
    end
  end
end
