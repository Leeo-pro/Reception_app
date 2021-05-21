class AddItem3ToAttendances < ActiveRecord::Migration[5.1]
  def change
    add_column :attendances, :name, :string
    add_column :attendances, :tel, :string
  end
end
