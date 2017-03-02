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
end
