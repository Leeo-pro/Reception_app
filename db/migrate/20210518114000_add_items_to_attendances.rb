class AddItemsToAttendances < ActiveRecord::Migration[5.1]
  def change
    add_reference :attendances, :reservation, foreign_key: true
  end
end