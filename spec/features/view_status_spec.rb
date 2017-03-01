require 'rails_helper'

feature 'View status' do
  # context 'when a booking is in progress' do
  #   let!(:booking){ Booking.create(name: 'Single booking', description: 'Has a long description here', start_time: DateTime.now-300, end_time: DateTime.now+300) }
  #   scenario 'status is busy' do
  #     visit 'bookings/status'
  #     expect(page).to have_content 'Busy'
  #   end
  # end

  context 'when there is no ongoing booking' do
    let!(:booking){ Booking.create(name: 'Single booking', description: 'Has a long description here', start_time: DateTime.now-600, end_time: DateTime.now-60) }
    scenario 'status is free' do
      visit 'bookings/status'
      expect(page).to have_content 'Free'
    end
  end
end
