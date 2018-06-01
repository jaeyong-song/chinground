class CreateBanArticles < ActiveRecord::Migration[5.2]
  def change
    create_table :ban_articles do |t|
      t.references :article, foreign_key: true
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
