require 'rails_helper'

feature 'Bookings' do
  context 'do not exist in the beginning' do
    let!(:room){ Room.create(name: 'Joy Room') }

    scenario 'so users see a message and a link to create a booking' do
      visit room_path(room)
      expect(page).to have_content 'No bookings yet!'
      expect(page).to have_link 'Create booking'
    end
  end

  context 'can be created' do
    let!(:room){ Room.create(name: 'Joy Room') }

    scenario 'via a form, then users can see the current week\'s calendar (with their booking, if in that week),' do
      visit room_path(room)
      click_link 'Create booking'
      fill_in 'Name', with: 'Workshop'
      fill_in 'Description', with: 'it is hard not to fall asleep'
      fill_in 'booking_start_time', with: DateTime.now
      fill_in 'booking_end_time', with: (DateTime.now + 5.minutes)
      click_button 'Book'

      expect(current_path).to eq room_path(room)
      expect(page).not_to have_content 'No bookings yet!'
      expect(page).to have_content 'Workshop'
    end

    scenario 'and the form has the relevant field validations.' do
      visit new_room_booking_path(room)
      expect(page).to have_xpath("//input[@required='required']")
    end
  end

  context 'have their own individual pages' do
    let!(:room){ Room.create(name: 'Joy Room') }

    scenario 'that display specific information and options' do
      visit room_path(room)
      click_link 'Create booking'
      fill_in 'Name', with: 'Workshop'
      fill_in 'Description', with: 'it is hard not to fall asleep'
      fill_in 'booking_start_time', with: DateTime.now
      fill_in 'booking_end_time', with: (DateTime.now + 5.minutes)
      click_button 'Book'
      expect(current_path).to eq room_path(room)
      click_link 'Workshop'
      expect(page).to have_content 'Workshop'
      expect(page).to have_content 'it is hard not to fall asleep'
      expect(page).to have_content DateTime.now.strftime('%e %B %Y, %H:%M')
      expect(page).to have_content (DateTime.now + 5.minutes).strftime('%e %B %Y, %H:%M')
      expect(page).to have_link 'Edit'
      expect(page).to have_link 'Cancel'
    end
  end

  context 'can be edited' do
    let!(:room){ Room.create(name: 'Joy Room') }

    scenario 'via a form' do
      visit room_path(room)
      click_link 'Create booking'
      fill_in 'Name', with: 'Workshop'
      fill_in 'Description', with: 'it is hard not to fall asleep'
      fill_in 'booking_start_time', with: DateTime.now
      fill_in 'booking_end_time', with: (DateTime.now + 5.minutes)
      click_button 'Book'
      expect(current_path).to eq room_path(room)
      click_link 'Workshop'
      click_link 'Edit'
      fill_in 'Name', with: 'Much tinier workshop'
      fill_in 'Description', with: 'so no sleeping'
      fill_in 'booking_start_time', with: (DateTime.now + 10.minutes)
      fill_in 'booking_end_time', with: (DateTime.now + 15.minutes)
      click_button 'Update'
      expect(current_path).to eq room_path(room)
      expect(page).to have_content 'Booking updated!'
      expect(page).to have_content 'Much tinier workshop'
      expect(page).to have_content (DateTime.now + 10.minutes).strftime('%H:%M')
    end
  end

  context 'can be cancelled' do
    let!(:room){ Room.create(name: 'Joy Room') }

    scenario 'via a link' do
      visit room_path(room)
      click_link 'Create booking'
      fill_in 'Name', with: 'Workshop'
      fill_in 'Description', with: 'it is hard not to fall asleep'
      fill_in 'booking_start_time', with: DateTime.now
      fill_in 'booking_end_time', with: (DateTime.now + 5.minutes)
      click_button 'Book'
      expect(current_path).to eq room_path(room)
      click_link 'Workshop'
      click_link 'Cancel'
      expect(current_path).to eq room_path(room)
      expect(page).to have_content 'Booking cancelled!'
      expect(page).not_to have_content 'Workshop'
      expect(page).not_to have_content (DateTime.now + 5.minutes).strftime('%H:%M')
    end
  end
end
