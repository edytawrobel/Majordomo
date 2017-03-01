class Booking < ApplicationRecord
  validates :name, presence: true, length: { minimum: 4, maximum: 32}
  validates :start_time, presence: true, allow_nil: false
  validates :end_time, presence: true, allow_nil: false

  def self.status?
    status = false
    Booking.all.each do |booking|
      status = true if booking.start_time <= DateTime.now && DateTime.now <= booking.end_time
    end
    status
  end
end
