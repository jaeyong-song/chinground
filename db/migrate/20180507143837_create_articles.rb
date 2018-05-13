class CreateArticles < ActiveRecord::Migration[5.1]
  def change
    create_table :articles do |t|
      t.string :title
      t.string :place
      t.text :content
      t.datetime :init_time
      t.datetime :fin_time
      t.integer :user_id

      t.timestamps
    end
    add_index :articles, :user_id
  end
end
