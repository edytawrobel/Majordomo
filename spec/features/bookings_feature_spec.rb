require 'rails_helper'

feature 'Bookings' do

  context 'no bookings have been added yet' do
    scenario 'should display a prompt to add a booking' do
      visit '/bookings'
      expect(page).to have_content 'No bookings yet'
      expect(page).to have_link 'Create booking'
    end
  end


  context 'a booking has been added' do
    before do
      Booking.create(name: 'workshop', description: 'it is hard not to fall asleep', start_time: DateTime.now, end_time: DateTime.now+60)
    end

    scenario 'should display content of the booking' do
      visit '/bookings'
      expect(page).to have_content 'workshop'
      expect(page).to have_content 'it is hard not to fall asleep'
    end

  end
end
