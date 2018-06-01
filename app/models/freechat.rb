class Freechat < ApplicationRecord
    has_many :free_messages, dependent: :destroy
    has_many :freechat_users, dependent: :destroy
    has_many :users, through: :freechat_users
    
    # 자유 채팅방 초대 거부 구현
    has_many :reject_freechats, dependent: :destroy
    has_many :rejected_users, through: :reject_freechats, source: :user
    
    after_create_commit { FreeroomNotiJob.perform_later(self) }
end
