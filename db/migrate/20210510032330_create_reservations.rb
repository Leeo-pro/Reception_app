class CreateReservations < ActiveRecord::Migration[5.1]
  def change
    create_table :reservations do |t|
      t.string :name
      t.date :date
      t.datetime :str_time
      t.datetime :fin_time
      t.integer :expected
      t.integer :reserved
      t.string :note

      t.timestamps
    end
  end
end
