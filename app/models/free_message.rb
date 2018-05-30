class FreeMessage < ApplicationRecord
  belongs_to :user
  belongs_to :freechat
  validates_presence_of :content
  validates_presence_of :user_id
  validates_presence_of :freechat_id
  after_create_commit { FreemessageBroadcastJob.perform_later(self) }
end
