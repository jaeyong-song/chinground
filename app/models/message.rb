class Message < ApplicationRecord
  belongs_to :user
  belongs_to :room
  validates_presence_of :content
  validates_presence_of :user_id
  validates_presence_of :chatroom_id
  after_create_commit { MessageBroadcastJob.perform_later(self)}
end