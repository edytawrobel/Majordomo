require 'rails_helper'

feature 'View status' do
  context 'when a booking is in progress' do
    let!(:room){ Room.create(name: 'Joy Room') }
    # let!(:booking){ Booking.create(name: 'First booking', description: 'Has a long description here', start_time: DateTime.now-300, end_time: DateTime.now+300, room_id: 1) }
    scenario 'status is busy' do
      visit room_path(room)
      click_link 'Book'
      fill_in 'Name', with: 'Workshop'
      fill_in 'Description', with: 'it is hard not to fall asleep'
      fill_in 'booking_start_time', with: DateTime.now
      fill_in 'booking_end_time', with: (DateTime.now + 60)
      click_button 'Book'
      visit status_room_bookings_path(room)
      expect(page).to have_content 'Busy'
    end
  end

  context 'when there is no ongoing booking' do
    let!(:room){ Room.create(name: 'Joy Room') }
    scenario 'status is free' do
      visit room_path(room)
      click_link 'Book'
      fill_in 'Name', with: 'Workshop'
      fill_in 'Description', with: 'it is hard not to fall asleep'
      fill_in 'booking_start_time', with: (DateTime.now - 600)
      fill_in 'booking_end_time', with: ( DateTime.now - 300)
      click_button 'Book'
      visit status_room_bookings_path(room)
      expect(page).to have_content 'Free'
    end
  end
end
