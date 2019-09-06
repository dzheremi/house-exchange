class User < ActiveRecord::Base

  has_many :properties, dependent: :destroy
  has_many :listings, dependent: :destroy
  has_many :bookings, dependent: :destroy
  has_many :point_logs, dependent: :destroy
  has_many :property_reviews, dependent: :destroy
  has_many :user_reviews, dependent: :destroy
  has_many :written_reviews, :class_name => "UserReview", :foreign_key => "author", dependent: :destroy
  has_many :tenants, dependent: :destroy

  validates :email_address, confirmation: true
  validates :email_address, uniqueness: true
  validates :email_address_confirmation, presence: true
  validates :password, confirmation: true
  validates :password_confirmation, presence: true
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :address_1, presence: true
  validates :suburb, presence: true
  validates :state, presence: true
  validates :post_code, presence: true
  validates :phone, presence: true

  def average_rating
    average = 0
    @reviews = self.user_reviews
    @reviews.each do |review|
      average += review.rating
    end
    unless @reviews.size == 0
      average = average / @reviews.size
    end
    return average
  end

  def point_balance
    @points = self.point_logs
    balance = 0
    @points.each do |p|
      balance += p.points
    end
    return balance
  end

  def enough_points_for(booking)
    if booking.point_cost <= self.point_balance
      return true
    else
      return false
    end
  end

  def add_points(points, booking = nil)
    @point_log = PointLog.new
    @point_log.user = self
    @point_log.booking = booking
    @point_log.points = points
    if @point_log.save
      return true
    else
      return false
    end
  end

  def remove_points(booking)
    if self.point_balance >= booking.point_cost
      @point_log = PointLog.new
      @point_log.user = self
      @point_log.booking = booking
      @point_log.points = 0 -  booking.point_cost
      if @point_log.save
        return true
      else
        return false
      end
    else
      return false
    end
  end

  def self.authenticate(email_address, password)
    @user = User.find_by_email_address(email_address)
    unless @user == nil
      if (@user.password == password)
        return @user
      else
        return false
      end
    end
  end
end
