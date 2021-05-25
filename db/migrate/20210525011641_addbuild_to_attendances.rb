class AddbuildToAttendances < ActiveRecord::Migration[5.1]
  def change
    add_column :attendances, :build_name, :string
  end
end
