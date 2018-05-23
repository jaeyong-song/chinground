class CreateChatroomUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :chatroom_users do |t|
      t.references :user, foreign_key: true
      t.references :room, foreign_key: true

      t.timestamps
    end
  end
end
