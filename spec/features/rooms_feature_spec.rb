require "rails_helper"

feature 'Rooms' do
  context 'do not exist in the beginning' do
    scenario 'so users see a message and a link to create a room' do
      visit rooms_path
      expect(page).to have_content 'No rooms yet'
      expect(page).to have_link 'Add room'
    end
  end

  context 'can be created' do
    scenario 'via a form, then users can see all existing rooms' do
      create_room_one
      expect(current_path).to eq rooms_path
      expect(page).to have_content 'Joy Room'
    end

    scenario 'UNLESS THEY DUPLICATE an existing room name,' do
      create_room_one
      create_room_one
      expect(current_path).to eq new_room_path
      expect(page).to have_content 'This room already exists!'
    end

    scenario 'and the form has the relevant field validations' do
      visit new_room_path
      expect(page).to have_xpath("//input[@required='required']")
    end
  end

  context 'have their own individual pages' do
    let!(:room){ Room.create(name: 'Living Room') }

    scenario 'that display specific information and options' do
      visit rooms_path
      click_link 'Living Room'
      expect(current_path).to eq room_path(room)
      expect(page).to have_content 'Living Room'
      expect(page).to have_css 'i.fa.fa-pencil'
      expect(page).to have_css 'i.fa.fa-trash'
    end
  end

  context 'can be edited' do
    let!(:room){ Room.create(name: 'Living Room') }

    scenario 'via a form' do
      visit room_path(room)
      click_link 'Edit'
      fill_in 'Name', with: 'Meeting Room 1'
      click_button 'Update'
      expect(current_path).to eq rooms_path
      expect(page).to have_content 'Room updated!'
      expect(page).to have_content 'Meeting Room 1'
    end
  end

  context 'can be deleted' do
    let!(:room){ Room.create(name: 'Living Room') }

    scenario 'via a link' do
      visit room_path(room)
      click_link 'Delete'
      expect(current_path).to eq rooms_path
      expect(page).to have_content 'Room deleted!'
      expect(page).not_to have_content 'Living Room'
    end
  end
end
