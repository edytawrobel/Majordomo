class AddValidationsToRooms < ActiveRecord::Migration[5.0]
  def up
    change_column_null :rooms, :name, false
    add_index :rooms, :name, unique: true
  end
end
