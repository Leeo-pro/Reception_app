class Add < ActiveRecord::Migration[5.1]
  def change
    add_column :reservations, :close, :integer
  end
end
