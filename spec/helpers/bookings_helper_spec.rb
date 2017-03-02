require 'rails_helper'

# Specs in this file have access to a helper object that includes
# the BookingsHelper. For example:
#
# describe BookingsHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end
#
# RSpec.describe BookingsHelper, type: :helper do
#   pending "add some examples to (or delete) #{__FILE__}"
# end

def create_booking_one
  visit room_path(room)
  click_link 'Create booking'
  fill_in 'Name', with: 'Workshop'
  fill_in 'Description', with: 'it is hard not to fall asleep'
  fill_in 'booking_start_time', with: DateTime.now
  fill_in 'booking_end_time', with: (DateTime.now + 5.minutes)
  click_button 'Book'
end

def create_booking_two
  visit room_path(room)
  click_link 'Create booking'
  fill_in 'Name', with: 'Overlaps the workshop'
  fill_in 'Description', with: 'ftw'
  fill_in 'booking_start_time', with: (DateTime.now + 2.minutes)
  fill_in 'booking_end_time', with: (DateTime.now + 12.minutes)
  click_button 'Book'
end

def create_booking_three
  visit room_path(room_two)
  click_link 'Create booking'
  fill_in 'Name', with: 'Another workshop'
  fill_in 'Description', with: 'at the same time, in another room'
  fill_in 'booking_start_time', with: DateTime.now
  fill_in 'booking_end_time', with: (DateTime.now + 5.minutes)
  click_button 'Book'
end

def edit_booking_one
  click_link 'Edit'
  fill_in 'Name', with: 'Much tinier workshop'
  fill_in 'Description', with: 'so no sleeping'
  fill_in 'booking_start_time', with: (DateTime.now + 10.minutes)
  fill_in 'booking_end_time', with: (DateTime.now + 15.minutes)
  click_button 'Update'
end
