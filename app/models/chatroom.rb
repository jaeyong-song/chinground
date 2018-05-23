class Chatroom < ApplicationRecord
    has_many :messages, dependent: :destroy
    # 채팅룸 join 테이블
    has_many :chatroom_users, dependent: :destroy
    has_many :users, through: :chatroom_users
    belongs_to :article
end
