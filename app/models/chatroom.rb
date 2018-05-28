class Chatroom < ApplicationRecord
    has_many :messages, dependent: :destroy
    # 채팅룸 join 테이블
    has_many :chatroom_users, dependent: :destroy
    has_many :users, through: :chatroom_users
    belongs_to :article
    # 게시물당 채팅방 한개
    validates_uniqueness_of :article_id
    after_create_commit { ChatroomNotiJob.perform_later(self) }
end
