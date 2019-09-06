class AuthenticationController < ApplicationController
  def login
    @user = User.new
  end

  def process_login
    if @user = User.authenticate(params[:user][:email_address], params[:user][:password])
      session[:current_user] = @user.id
      @user = current_user
      redirect_to :action=>'list', :controller=>'booking'
    else
      flash[:error] = 'Invalid username or password.'
      redirect_to :action=>'login'
    end
  end

  def logout
    session[:current_user] = nil
    flash[:notice] = 'You have been logged out... See you next time!'
    redirect_to :action=>'login'
  end

  def register
    @user = User.new
  end
  
  def create_user
    @user = User.new(user_params)
    @points = PointLog.new
    @points.user = @user
    @points.points = 500
    if @user.save
      if @points.save
        flash[:notice] = 'Your account could not be created.'
        redirect_to :action=>'login'
      else
        flash[:error] = 'Your account could not be created.'
      end
    else
      flash[:error] = 'Your account could not be created.'
      render :action=>'register'
    end
  end

  private
  def user_params
    params.require(:user).permit(:email_address, :email_address_confirmation, :password, :password_confirmation,
                                 :first_name, :last_name, :address_1, :address_2, :suburb, :state, :post_code,
                                 :phone)
  end
end
