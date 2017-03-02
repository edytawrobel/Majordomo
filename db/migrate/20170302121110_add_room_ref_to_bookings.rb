class AddRoomRefToBookings < ActiveRecord::Migration[5.0]
  def change
    add_reference :bookings, :room, foreign_key: true
  end
end
