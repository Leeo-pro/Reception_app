class AddColumnArticles < ActiveRecord::Migration[5.1]
  def change_column
    add_column :article, :news_id, :string
  end
end
