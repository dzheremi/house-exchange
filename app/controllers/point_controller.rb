class PointController < ApplicationController

  before_filter :is_logged_in

  def list
    @point_log = current_user.point_logs.order(created_at: :desc)
  end

  def process_transaction
    @point_log = PointLog.new
    @point_log.user = current_user
    if params[:points] == ''
      flash[:warning] = 'Please specify the number of points you wish to purchase.'
      render :action=>'purchase'
    else
      @point_log.points = params[:points]
      if @point_log.save
        flash[:notice] = 'Your purchase was successful.'
        redirect_to :action=>'list'
      else
        flash[:warning] = 'Your purchase could not be completed.'
        render :action=>'purchase'
      end
    end
  end

end
