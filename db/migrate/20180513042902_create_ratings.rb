class CreateRatings < ActiveRecord::Migration[5.1]
  def change
    create_table :ratings do |t|
      t.integer :user_id
      t.integer :article_id
      t.float :rate

      t.timestamps
    end
  end
end
