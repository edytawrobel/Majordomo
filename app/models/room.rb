class Room < ApplicationRecord
  validates :name, uniqueness: true, presence: true, length: { minimum: 4, maximum: 16}

  has_many :bookings, dependent: :destroy
end
