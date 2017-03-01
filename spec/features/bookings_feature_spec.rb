require 'rails_helper'

feature 'Bookings' do
  context 'no bookings have been added yet' do
    scenario 'should display a prompt to add a booking' do
      visit bookings_path
      expect(page).to have_content 'No bookings yet'
      expect(page).to have_link 'Create booking'
    end
  end

  context 'existing bookings displayed' do
    before do
      Booking.create(name: 'workshop', description: 'it is hard not to fall asleep', start_time: DateTime.now, end_time: DateTime.now+60)
    end

    scenario 'should display content of the booking' do
      visit bookings_path
      expect(page).to have_content 'workshop'
      expect(page).to have_content 'it is hard not to fall asleep'
    end
  end

  context 'creating a new booking' do
    scenario 'should display content of the booking' do
      visit new_booking_path
      fill_in 'Name', with: 'workshop'
      fill_in 'Description', with: 'it is hard not to fall asleep'
      fill_in 'booking_start_time', with: '2017-01-01 17:19:00'
      fill_in 'booking_end_time', with: '2017-01-01 17:21:00'
      click_button 'Book'

      expect(current_path).to eq bookings_path
      expect(page).to have_content 'workshop'
      expect(page).to have_content 'it is hard not to fall asleep'
      expect(page).to have_content '1 January 2017, 17:19'
      expect(page).to have_content '1 January 2017, 17:21'
    end
  end

  context 'viewing a single booking' do
    let!(:booking){ Booking.create(name: 'Single booking', description: 'Has a long description here', start_time: DateTime.now, end_time: DateTime.now+300) }

    scenario 'should display booking info and options' do
      visit bookings_path
      click_link 'Single booking'
      expect(current_path).to eq booking_path(booking)
      expect(page).to have_content 'Single booking'
      expect(page).to have_content 'Has a long description here'
      expect(page).to have_link 'Edit'
    end
  end
end
