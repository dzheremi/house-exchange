class BookingController < ApplicationController

  before_filter :is_logged_in

  def new_from_listing
    @error = false
    @point_error = false
    @user = current_user
    @listing = Listing.find(params[:id])
    @booking = Booking.new(booking_params)
    @booking.listing = @listing
    @booking.user = @user
    @booking.point_cost = @booking.calculate_cost
    if @booking.start < @listing.start || @booking.end <= @listing.start
      @error = true
    end
    if @booking.end > @listing.end || @booking.start >= @listing.end
      @error = true
    end
    unless @user.enough_points_for(@booking)
      @point_error = true
    end
    if @booking.user == @listing.user
      flash[:warning] = 'You cannot book your own listing.'
      redirect_to :action=>'list', :controller=>'listing'
    end
  end

  def new_from_tenant
    @user = current_user
    @tenant = Tenant.find(params[:id])
    @booking = Booking.new(booking_params)
    @booking.tenant = @tenant
    @booking.user = @user
    if @booking.start == @tenant.start && @booking.end == @tenant.end
      @point_warning = false
      @range_warning = false
      @rating_warning = false
      if @booking.listing.daily_points > @tenant.maximum_daily_points
        @point_warning = true
      end
      if @booking.start < @booking.listing.start || @booking.end <= @booking.listing.start
        @range_warning = true
      end
      if @booking.end > @booking.listing.end || @booking.start >= @booking.listing.end
        @range_warning = true
      end
      if @booking.listing.minimum_rating > @tenant.user.average_rating
        @rating_warning = true
      end
    end
    if @booking.user == @booking.tenant.user
      flash[:warning] = 'You cannot make an offer to yourself.'
      redirect_to :action=>'list', :controller=>'tenant'
    end
  end

  def save
    @saved = false
    @user = current_user
    if params[:booking_from] == 'listing'
      @listing = Listing.find(params[:id])
      @booking = Booking.new(booking_params)
      @booking.listing = @listing
      @booking.user = @user
      if @booking.user != @listing.user
        if @booking.start >= @listing.start && @booking.end > @listing.start
          if @booking.end <= @listing.end && @booking.start < @listing.end
            @booking.point_cost = @booking.calculate_cost
            if @user.enough_points_for(@booking)
              if @booking.save
                @saved = true
                flash[:notice] = 'Your booking request has been made.'
                redirect_to :action=>'list'
              end
            end
          end
        end
      end
    end
    if params[:booking_from] == 'tenant'
      @tenant = Tenant.find(params[:id])
      @listing = Listing.find(params[:listing_id])
      @booking = Booking.new(booking_params)
      @booking.tenant = @tenant
      @booking.listing = @listing
      @booking.user = @user
      if @booking.user != @tenant.user
        if @booking.start == @tenant.start
          if @booking.end == @tenant.end
            @booking.point_cost = @booking.calculate_cost
            if @booking.save
              @saved = true
              flash[:notice] = 'Your offer has been made.'
              redirect_to :action=>'list'
            end
          end
        end
      end
    end
    unless @saved
      flash[:error] = 'Your request could not be processed.'
      @error = true
      if params[:booking_from] == 'listing'
        unless @user.enough_points_for(@booking)
          @point_error = true
        end
        render :action=>'new_from_listing'
      end
      if params[:booking_from] == 'tenant'
        render :action=>'new_from_tenant'
      end
    end
  end

  def list
    @user = current_user
    @properties = @user.properties
    @bookings = @user.bookings
    @tenants = @user.tenants
    @listing_bookings = []
    @offer_bookings = []
    @tenant_bookings = []
    @your_bookings = []
    @properties.each do |p|
      @listings = p.listings
      @listings.each do |l|
        l.bookings.order(created_at: :desc).each do |b|
          if b.tenant_id.nil?
            @listing_bookings << b
          else
            @offer_bookings << b
          end
        end
      end
    end
    @tenants.each do |t|
      t.bookings.order(created_at: :desc).each do |b|
        unless b.nil?
          @tenant_bookings << b
        end
      end
    end
    @bookings.order(created_at: :desc).each do |b|
      if b.tenant_id.nil?
        @your_bookings << b
      end
    end
  end

  def tenant_accept
    accepted = false
    @booking = Booking.find(params[:id])
    if @booking
      if @booking.tenant.user.remove_points(@booking)
        if @booking.user.add_points(@booking.point_cost, @booking)
          @booking.tenant_approved = true
          @booking.tenant_approved_at = Time.now
          if @booking.save
            accepted  = true
            flash[:notice] = 'You have accepted a booking offer.'
            redirect_to :action=>'list'
          end
        end
      end
    end
    unless accepted
      flash[:warning] = 'You\'re offer could not be accepted.'
      redirect_to :action=>'list'
    end
  end

  def tenant_decline
    declined = false
    @booking = Booking.find(params[:id])
    if @booking
      @booking.tenant_declined = true
      @booking.tenant_declined_at = Time.now
      if @booking.save
        declined = true
        flash[:notice] = 'You have declined a booking offer.'
        redirect_to :action=>'list'
      end
    end
    unless declined
      flash[:warning] = 'You\'re offer could not be declined.'
      redirect_to :action=>'list'
    end
  end

  def owner_accept
    accepted = false
    @booking = Booking.find(params[:id])
    if @booking
      if @booking.user.remove_points(@booking)
        if @booking.listing.user.add_points(@booking.point_cost, @booking)
          @booking.owner_approved = true
          @booking.owner_approved_at = Time.now
          if @booking.save
            accepted  = true
            flash[:notice] = 'You have accepted a booking offer.'
            redirect_to :action=>'list'
          end
        end
      end
    end
    unless accepted
      flash[:warning] = 'This offer could not be accepted.'
      redirect_to :action=>'list'
    end
  end

  def owner_decline
    declined = false
    @booking = Booking.find(params[:id])
    if @booking
      @booking.owner_declined = true
      @booking.owner_declined_at = Time.now
      if @booking.save
        declined = true
        flash[:notice] = 'You have declined a booking offer.'
        redirect_to :action=>'list'
      end
    end
    unless declined
      flash[:warning] = 'You\'re offer could not be declined.'
      redirect_to :action=>'list'
    end
  end

  private
  def booking_params
    params.require(:booking).permit(:start, :end, :listing_id)
  end
end
