class AddDetails7ToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :meta, :string
  end
end
