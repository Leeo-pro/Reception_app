class AddColumnArticles2 < ActiveRecord::Migration[5.1]
  def up
    add_column :articles, :category, :string
  end
end
