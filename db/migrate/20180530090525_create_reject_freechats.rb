class CreateRejectFreechats < ActiveRecord::Migration[5.2]
  def change
    create_table :reject_freechats do |t|
      t.references :user, foreign_key: true
      t.references :freechat, foreign_key: true

      t.timestamps
    end
  end
end
