class AddValidationsToBookings < ActiveRecord::Migration[5.0]
  def up
    change_column_null :bookings, :name, false
    change_column_null :bookings, :start_time, false
    change_column_null :bookings, :end_time, false
  end
end
