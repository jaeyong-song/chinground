class Freechat < ApplicationRecord
    has_many :free_messages, dependent: :destroy
    has_many :freechat_users, dependent: :destroy
    has_many :users, through: :freechat_users
    
    has_many :reject_freechats, dependent: :destroy
    has_many :rejected_users, through: :reject_freechats, source: :user
    
    after_create_commit { FreeroomNotiJob.perform_later(self) }
end
