class ReviewController < ApplicationController
  def property
    @review = PropertyReview.new
    @booking = Booking.find(params[:id])
    @property = @booking.listing.property
  end

  def property_save
    @review = PropertyReview.new(property_review_params)
    @booking = Booking.find(params[:id])
    @booking.tenant_reviewed = true
    @booking.tenant_reviewed_at = Time.now
    if @booking.save
      @review.property = @booking.listing.property
      @review.user = current_user
      if @review.save
        flash[:notice] = 'Your review has published. Thank you for your feedback.'
        redirect_to :action=>'list', :controller=>'booking'
      else
        flash[:warning] = 'Your review cannot be published.'
        render action=>'property'
      end
    else
      flash[:warning] = 'Your review cannot be published.'
      render action=>'property'
    end
  end

  def user
    @review = UserReview.new
    @booking = Booking.find(params[:id])
    if @booking.tenant.nil?
      @user = @booking.user
    else
      @user = @booking.tenant.user
    end
  end

  def user_save
    @review = UserReview.new(user_review_params)
    @booking = Booking.find(params[:id])
    @booking.owner_reviewed = true
    @booking.owner_reviewed_at = Time.now
    if @booking.save
      @review.author = current_user
      if @booking.tenant.nil?
        @review.user = @booking.user
      else
        @review.user = @booking.tenant.user
      end
      if @review.save
        flash[:notice] = 'Your review has been published. Thank you for your feedback.'
        redirect_to :action=>'list', :controller=>'booking'
      else
        flash[:warning] = 'Your review cannot be published.'
        render action=>'property'
      end
    else
      flash[:warning] = 'Your review cannot be published.'
      render action=>'property'
    end
  end

  private
  def property_review_params
    params.require(:property_review).permit(:rating, :comment)
  end
  def user_review_params
    params.require(:user_review).permit(:rating, :comment)
  end
end
