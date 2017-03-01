class Booking < ApplicationRecord
  validates :name, presence: true, length: { minimum: 4, maximum: 32}
  validates :start_time, presence: true, allow_nil: false
  validates :end_time, presence: true, allow_nil: false
end
