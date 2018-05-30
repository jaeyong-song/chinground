class Freechat < ApplicationRecord
    has_many :free_messages, dependent: :destroy
    has_many :freechat_users, dependent: :destroy
    has_many :users, through: :freechat_users
    
    after_create_commit { FreeroomNotiJob.perform_later(self) }
end
