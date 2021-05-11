class CreateArticles < ActiveRecord::Migration[5.1]
  def change
    create_table :articles do |t|
      t.integer :news_id
      t.string :memo

      t.timestamps
    end
  end
end
