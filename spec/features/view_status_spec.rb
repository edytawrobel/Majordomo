require 'rails_helper'

feature 'Users can view a room status' do
  context 'and when a booking is in progress' do
    let!(:room){ Room.create(name: 'Joy Room') }
    # let!(:booking){ Booking.create(name: 'First booking', description: 'Has a long description here', start_time:(DateTime.now - 5), end_time: (DateTime.now + 5.minutes), room_id: 1) }
    scenario 'the status is "in use"' do
      visit room_path(room)
      click_link 'Create booking'
      fill_in 'Name', with: 'Workshop'
      fill_in 'Description', with: 'it is hard not to fall asleep'
      fill_in 'booking_start_time', with: DateTime.now
      fill_in 'booking_end_time', with: (DateTime.now + 5.minutes)
      click_button 'Book'
      visit status_room_bookings_path(room)
      expect(page).to have_content 'Room in use'
    end
  end

  context 'and when no booking is ongoing' do
    let!(:room){ Room.create(name: 'Joy Room') }
    scenario 'the status is "available"' do
      visit room_path(room)
      click_link 'Create booking'
      fill_in 'Name', with: 'Workshop'
      fill_in 'Description', with: 'it is hard not to fall asleep'
      fill_in 'booking_start_time', with: (DateTime.now - 10.minutes)
      fill_in 'booking_end_time', with: ( DateTime.now - 5.minutes)
      click_button 'Book'
      visit status_room_bookings_path(room)
      expect(page).to have_content 'Room available'
    end
  end
end
