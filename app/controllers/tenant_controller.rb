class TenantController < ApplicationController

  before_filter :is_logged_in

  def list
    @tenants = Tenant.where(active: true).order(created_at: :desc)
  end

  def results
    @property = Property.find(params[:property_id])
    unless params[:date].nil?
      @date = DateTime.civil_from_format(:local, params[:date]['year'].to_i, params[:date]['month'].to_i, params[:date]['day'].to_i, 0, 0, 0)
    end
    @tenants = Tenant.search_by_suburb_and_week(@property.suburb, @date)
  end

  def view
    @tenant = Tenant.find(params[:id])
    @user = current_user
    @listings = @user.listings
    @booking = Booking.new
  end

  def user_tenants
    @tenants = current_user.tenants
  end

  def new
    @tenant = Tenant.new
  end

  def save
    @tenant = Tenant.new(tenant_params)
    @tenant.user = current_user
    if @tenant.save
      flash[:notice] = 'Your request has been added!'
      redirect_to :action=>'list'
    else
      flash[:error] = 'Your request could not be saved!'
      render :action=>'new'
    end
  end

  def edit
    @tenant = Tenant.find(params[:id])
  end

  def update
    @tenant = Tenant.find(params[:id])
    if @tenant.update(tenant_params)
      flash[:notice] = 'Your request has been updated!'
      redirect_to :action=>'user_tenants'
    else
      flash[:warning] = 'Your request could not be updated!'
      render :action=>'edit'
    end
  end

  def delete
    @tenant = Tenant.find(params[:id])
    if @tenant.delete
      flash[:notice] = 'Your request has been deleted!'
    else
      flash[:warning] = 'Your request could not be deleted!'
    end
    redirect_to :action=>'user_tenants'
  end

  private
  def tenant_params
    params.require(:tenant).permit(:start, :end, :maximum_daily_points, :suburb, :active)
  end
end
