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
    let!(:room_two){ Room.create(name: 'Living Room') }

    scenario 'via a form, then users can see the current week\'s calendar (with their booking, if in that week),' do
      create_booking_one
      expect(current_path).to eq room_path(room)
      expect(page).not_to have_content 'No bookings yet!'
      expect(page).to have_content 'Workshop'
    end

    scenario 'UNLESS THEY OVERLAP (for a given room),' do
      create_booking_one
      create_booking_two
      expect(current_path).to eq new_room_booking_path(room)
      expect(page).to have_content 'This booking overlaps others'
      expect(page).not_to have_content 'Overlaps the workshop'
    end

    scenario 'but it is ok for them to overlap if they are in DIFFERENT rooms,' do
      create_booking_one
      create_booking_three
      expect(current_path).to eq room_path(room_two)
      expect(page).to have_content 'Another workshop'
    end

    scenario 'and UNLESS IT ENDS BEFORE IT BEGINS,' do
      create_booking_four
      expect(current_path).to eq new_room_booking_path(room)
      expect(page).to have_content 'This booking overlaps others or can\'t otherwise be created'
      expect(page).not_to have_content 'It ends before it begins'
    end

    scenario 'and the form has the relevant field validations' do
      visit new_room_booking_path(room)
      expect(page).to have_xpath("//input[@required='required']")
    end
  end

  context 'have their own individual pages' do
    let!(:room){ Room.create(name: 'Joy Room') }

    scenario 'that display specific information and options' do
      create_booking_one
      expect(current_path).to eq room_path(room)
      click_link 'Workshop'
      expect(page).to have_content 'Workshop'
      expect(page).to have_content 'it is hard not to fall asleep'
      expect(page).to have_content DateTime.now.strftime('%e %B %Y, %H:%M')
      expect(page).to have_content (DateTime.now + 5.minutes).strftime('%H:%M')
      expect(page).to have_css 'i.fa.fa-pencil'
      expect(page).to have_css 'i.fa.fa-trash'
    end
  end

  context 'can be edited' do
    let!(:room){ Room.create(name: 'Joy Room') }

    scenario 'via a form' do
      create_booking_one
      expect(current_path).to eq room_path(room)
      click_link 'Workshop'
      edit_booking_one
      expect(current_path).to eq room_path(room)
      expect(page).to have_content 'Booking updated!'
      expect(page).to have_content 'Much tinier workshop'
      expect(page).to have_content (DateTime.now + 10.minutes).strftime('%H:%M')
    end
  end

  context 'can be cancelled' do
    let!(:room){ Room.create(name: 'Joy Room') }

    scenario 'via a link' do
      create_booking_one
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
