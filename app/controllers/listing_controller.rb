class ListingController < ApplicationController

  before_filter :is_logged_in, :except=>[:list, :search, :results, :view, :list_featured]

  def list
    @listings = Listing.where(active: true).order(created_at: :desc)
  end

  def list_featured
    @listings = Listing.recently_added
    @tenants = Tenant.recently_added
  end

  def search
    @user = current_user
    unless @user.nil?
      @properties = @user.properties
    end
  end

  def results
    unless params[:date].nil?
      @date = DateTime.civil_from_format(:local, params[:date]['year'].to_i, params[:date]['month'].to_i, params[:date]['day'].to_i, 0, 0, 0)
    end
    @listings = Listing.search_by_suburb_and_week(params[:suburb], @date)
  end

  def view
    @user = current_user
    @listing = Listing.find(params[:id])
    @booking = Booking.new
    @images = @listing.property.property_images
    unless @listing.active
      redirect_to :action=>'list'
    end
  end

  def user_listings
    @listings = current_user.listings
  end

  def new
    @properties = current_user.properties
    if @properties.size == 0
      flash[:notice] = 'You need to add a property to your profile first.'
      redirect_to :action=>'new', :controller=>'property'
    end
    @listing = Listing.new
  end

  def save
    @listing = Listing.new(listing_params)
    @property = @listing.property
    if @property.user == current_user
      @listing.user = current_user
      # Change this when ready...
      @listing.featured = true
      if @listing.save
        flash[:notice] = 'Your listing has been added.'
        redirect_to :action=>'list'
      else
        @properties = current_user.properties
        flash[:error] = 'Your listing could not be saved.'
        render :action=>'new'
      end
    else
      flash[:error] = 'You are not allowed to list this property.'
      redirect_to :action=>'list'
    end
  end

  def edit
    @listing = Listing.find(params[:id])
    unless @listing.user == current_user
      flash[:error] = 'You are not allowed to edit this listing.'
      redirect_to :action=>'user_listings'
    end
    @properties = current_user.properties
  end

  def update
    @listing = Listing.find(params[:id])
    if @listing.user == current_user
      if @listing.update(listing_params)
        flash[:notice] = 'Your listing has been updated.'
        redirect_to :action=>'user_listings'
      else
        flash[:error] = 'Your listing could not be updated.'
        render :action=>'edit'
      end
    else
      flash[:error] = 'You are not allowed to edit this listing.'
      redirect_to :action=>'user_listings'
    end
  end

  def delete
    @listing = Listing.find(params[:id])
    if @listing.user == current_user
      if @listing.delete
        flash[:notice] = 'Your listing has been deleted.'
      else
        flash[:error] = 'Your listing could not be deleted.'
      end
    else
      flash[:error] = 'You are not allowed to delete this listing.'
    end
    redirect_to :action=>'user_listings'
  end

  private
  def listing_params
    params.require(:listing).permit(:property_id, :start, :end, :daily_points, :minimum_rating, :active, :notes)
  end
end
