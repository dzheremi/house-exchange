class Property < ActiveRecord::Base

  belongs_to :user
  has_and_belongs_to_many :property_features
  has_many :listings, dependent: :destroy
  has_many :property_images, dependent: :destroy
  has_many :property_reviews, dependent: :destroy

  validates :title, uniqueness: true
  validates :title, presence: true
  validates :address_1, presence: true
  validates :suburb, presence: true
  validates :state, presence: true
  validates :post_code, presence: true
  validates :description, presence: true

  def average_rating
    average = 0
    @reviews = self.property_reviews
    @reviews.each do |review|
      average += review.rating
    end
    unless @reviews.size == 0
      average = average / @reviews.size
    end
    return average
  end

end
