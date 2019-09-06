class BookingValidator < ActiveModel::Validator
  def validate(record)
    if record.start > record.end
      record.errors[:start] << 'Start date needs to be before end date.'
      record.errors[:end] << 'End date needs to be after start date.'
    end
    if record.start < Date.today
      record.errors[:start] << 'Start date must be in the future.'
    end
    if record.end < Date.today
      record.errors[:end] << 'End date must be in the future.'
    end
  end
end

class Booking < ActiveRecord::Base
  belongs_to :listing
  belongs_to :tenant
  belongs_to :user
  has_many :point_logs, dependent: :destroy

  validates :start, presence: true
  validates :end, presence: true
  validates_with BookingValidator

  def get_html_status
    status = '<font color="#ff8800"><b>Pending<b></font>'
    if self.get_status == 'approved'
      status = '<font color="#00aa00"><b>Approved</b></font>'
    end
    if self.get_status == 'declined'
      status = '<font color=#aa0000"><b>Declined</b></font>'
    end
    if self.get_status == 'lapsed'
      status = '<font color="#ff0000"><b>Lapsed</b></font>'
    end
    return status
  end

  def get_status
    status = 'pending'
    if self.tenant_approved || self.owner_approved
      status = 'approved'
    end
    if self.tenant_declined || self.owner_declined
      status = 'declined'
    end
    if (self.start <= Date.today) && tenant_approved.nil? && owner_approved.nil? && tenant_declined.nil? && owner_declined.nil?
      status = 'lapsed'
    end
    if status == 'pending'
      if self.created_at < (Time.now - 1.day)
        status = 'lapsed'
      end
    end
    return status
  end

  def calculate_cost
    duration = (self.end - self.start).to_i
    if self.tenant.nil?
      cost = self.listing.daily_points
    else
      cost = self.tenant.maximum_daily_points
    end
    return duration * cost
  end

end
