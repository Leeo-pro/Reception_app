class AddDetails06041ToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :name, :string
    add_column :users, :affiliation, :string
    add_column :users, :employee_number, :integer
    add_column :users, :superior, :boolean, default: false
    add_column :users, :designated_work_start_time, :datetime
    add_column :users, :designated_work_end_time, :datetime
  end
end
