require 'rails_helper'

feature 'Bookings' do
  # context 'no bookings have been added yet' do
  #   scenario 'should display a prompt to add a booking' do
  #     visit bookings_path
  #     expect(page).to have_content 'No bookings yet'
  #     expect(page).to have_link 'Create booking'
  #   end
  # end

  context 'creating a new booking' do
    let!(:room){ Room.create(name: 'Joy Room') }

    scenario 'should display content of the booking' do
      visit room_path(room)
      click_link 'Create booking'
      fill_in 'Name', with: 'Workshop'
      fill_in 'Description', with: 'it is hard not to fall asleep'
      fill_in 'booking_start_time', with: DateTime.now
      fill_in 'booking_end_time', with: (DateTime.now + 300)
      click_button 'Book'

      expect(current_path).to eq room_path(room)
      expect(page).to have_content 'Workshop'
    end

    scenario 'should display validations' do
      visit new_room_booking_path(room)
      expect(page).to have_xpath("//input[@required='required']")
    end
  end

  context 'viewing a single booking' do
    let!(:room){ Room.create(name: 'Joy Room') }

    scenario 'should display booking info and options' do
      visit room_path(room)
      click_link 'Create booking'
      fill_in 'Name', with: 'Workshop'
      fill_in 'Description', with: 'it is hard not to fall asleep'
      fill_in 'booking_start_time', with: DateTime.now
      fill_in 'booking_end_time', with: (DateTime.now + 5)
      click_button 'Book'
      expect(current_path).to eq room_path(room)
      save_and_open_page
      click_link 'Workshop'
      expect(page).to have_content 'Workshop'
      expect(page).to have_content 'it is hard not to fall asleep'
      expect(page).to have_link 'Edit'
      expect(page).to have_link 'Cancel'
    end
  end

  context 'editing a booking' do
    let!(:room){ Room.create(name: 'Joy Room') }

    scenario 'should update booking info' do
      visit room_path(room)
      click_link 'Book'
      fill_in 'Name', with: 'Workshop'
      fill_in 'Description', with: 'it is hard not to fall asleep'
      fill_in 'booking_start_time', with: '2017-01-01 17:19:00'
      fill_in 'booking_end_time', with: '2017-01-01 17:21:00'
      click_button 'Book'
      expect(current_path).to eq room_path(room)
      click_link 'Workshop'
      click_link 'Edit'
      fill_in 'Description', with: 'Has a much shorter description now'
      fill_in 'booking_start_time', with: '2017-02-01 16:00:00'
      fill_in 'booking_end_time', with: '2017-02-01 16:10:00'
      click_button 'Update'
      expect(current_path).to eq room_path(room)
      expect(page).to have_content 'Booking updated!'
      expect(page).to have_content 'Has a much shorter description now'
      expect(page).to have_content '1 February 2017, 16:00'
    end
  end

  context 'cancelling a booking' do
    let!(:room){ Room.create(name: 'Joy Room') }

    scenario 'should destroy that booking' do
      visit room_path(room)
      click_link 'Book'
      fill_in 'Name', with: 'Workshop'
      fill_in 'Description', with: 'it is hard not to fall asleep'
      fill_in 'booking_start_time', with: '2017-01-01 17:19:00'
      fill_in 'booking_end_time', with: '2017-01-01 17:21:00'
      click_button 'Book'
      expect(current_path).to eq room_path(room)
      click_link 'Workshop'
      click_link 'Cancel'
      expect(current_path).to eq room_path(room)
      expect(page).to have_content 'Booking cancelled!'
      expect(page).not_to have_content 'Workshop'
      expect(page).not_to have_content '1 January 2017, 17:19'
    end
  end
end
