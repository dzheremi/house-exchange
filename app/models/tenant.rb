class Tenant < ActiveRecord::Base
  belongs_to :user
  has_many :bookings, dependent: :destroy

  def self.recently_added
    self.where(created_at: (Time.now - 3.days)..(Time.now)).order(created_at: :desc)
  end

  def self.search_by_suburb_and_week(suburb, date)
    if suburb
      if date
        self.search_by_suburb(suburb).search_by_week(date)
      else
        all()
      end
    else
      all()
    end
  end

  def self.search_by_suburb(query)
    if query
      self.where(suburb: query)
    else
      all()
    end
  end

  def self.search_by_week(date)
    if date
      self.search_by_start_week(date).search_by_end_week(date)
    else
      all()
    end
  end

  def self.search_by_start_week(date)
    if date
      self.where(start: date.at_beginning_of_week..date.at_end_of_week)
    else
      all()
    end
  end

  def self.search_by_end_week(date)
    if date
      self.where(end: date.at_beginning_of_week..date.at_end_of_week)
    else
      all()
    end
  end

end
