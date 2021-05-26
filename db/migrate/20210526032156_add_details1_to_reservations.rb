class AddDetails1ToReservations < ActiveRecord::Migration[5.1]
  def change
    add_column :reservations, :day, :string
  end
end
