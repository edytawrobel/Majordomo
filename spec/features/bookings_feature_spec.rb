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
      click_button 'Create Booking'

      expect(current_path).to eq bookings_path
      expect(page).to have_content 'workshop'
      expect(page).to have_content 'it is hard not to fall asleep'
      expect(page).to have_content '1 January 2017, 17:19'
      expect(page).to have_content '1 January 2017, 17:21'
    end
  end
end

# today = Time.parse("2017-02-28 09:02:56 +0100")
