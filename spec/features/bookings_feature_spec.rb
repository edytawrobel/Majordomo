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
      visit bookings_path
      click_link 'Create booking'
      fill_in 'Name', with: 'workshop'
      fill_in 'Description', with: 'it is hard not to fall asleep'
      select('28', from: 'Day')
      select('2', from: 'Month')
      select('2017', from: 'Year')
      select('09', from: 'StartHour')
      select('00', from: 'StartMinute')
      select('11', from: 'EndHour')
      select('00', from: 'EndMinute')
      expect(page).to have_content 'workshop'
      expect(page).to have_content 'it is hard not to fall asleep'
    end
  end
end

# today = Time.parse("2017-02-28 09:02:56 +0100")
