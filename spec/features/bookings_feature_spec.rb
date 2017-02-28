require 'rails_helper'

feature 'Bookings' do
  context 'no bookings have been added yet' do
    scenario 'should display a prompt to add a booking' do
      visit '/bookings'
      expect(page).to have_content 'No bookings yet'
      expect(page).to have_link 'Create booking'
    end
  end
end
