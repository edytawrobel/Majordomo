class Booking < ApplicationRecord
  validates :name, presence: true, length: { minimum: 4, maximum: 32}
  validates :start_time, presence: true, allow_nil: false
  validates :end_time, presence: true, allow_nil: false

  validates :start_time, :end_time, overlap: {:scope => 'room_id'}
  validates :end_time, date: { after: :start_time }

  belongs_to :room

  def self.status?(current_room_id)
    status = false
    current_room_bookings = Booking.where(room_id: current_room_id)
    current_room_bookings.each do |booking|
      status = true if booking.start_time <= DateTime.now && DateTime.now <= booking.end_time
    end
    status
  end
end
