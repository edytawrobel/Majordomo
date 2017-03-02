require "rails_helper"

feature 'Rooms' do
  context 'no rooms have been added yet' do
    scenario 'should display a prompt to add a room' do
      visit rooms_path
      expect(page).to have_content 'No rooms yet'
      expect(page).to have_link 'Add room'
    end
  end

  context 'existing rooms displayed' do
    before do
      Room.create(name: 'Joy Room')
    end

    scenario 'should display the room\'s name' do
      visit rooms_path
      expect(page).to have_content 'Joy Room'
    end
  end

  context 'creating a new room' do
    scenario 'should display its name' do
      visit new_room_path
      fill_in 'Name', with: 'Joy Room'
      click_button 'Add'

      expect(current_path).to eq rooms_path
      expect(page).to have_content 'Joy Room'
    end

    scenario 'should display validations' do
      visit new_room_path
      expect(page).to have_xpath("//input[@required='required']")
    end

    scenario 'should fail when duplicate name provided' do
      visit new_room_path
      fill_in 'Name', with: 'Joy Room'
      click_button 'Add'
      visit new_room_path
      fill_in 'Name', with: 'Joy Room'
      click_button 'Add'
      expect(current_path).to eq new_room_path
      expect(page).to have_content 'This room already exists!'
    end
  end

  context 'viewing a single room' do
    let!(:room){ Room.create(name: 'Living Room') }

    scenario 'should display room\'s name' do
      visit rooms_path
      click_link 'Living Room'
      expect(current_path).to eq room_path(room)
      expect(page).to have_content 'Living Room'
    end
  end

  context 'editing a room' do
    let!(:room){ Room.create(name: 'Living Room') }

    scenario 'should update booking info' do
      visit room_path(room)
      click_link 'Edit'
      fill_in 'Name', with: 'Meeting Room 1'
      click_button 'Update'
      expect(current_path).to eq rooms_path
      expect(page).to have_content 'Room updated!'
      expect(page).to have_content 'Meeting Room 1'
    end
  end

  context 'deleting a room' do
    let!(:room){ Room.create(name: 'Living Room') }

    scenario 'should destroy that room' do
      visit room_path(room)
      click_link 'Delete'
      expect(current_path).to eq rooms_path
      expect(page).to have_content 'Room deleted!'
      expect(page).not_to have_content 'Living Room'
    end
  end
end
