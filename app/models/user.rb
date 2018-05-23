class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :confirmable
         
  has_many :articles, dependent: :destroy
  has_many :messages, dependent: :destroy
  has_many :ratings, dependent: :destroy
  has_many :article_users, dependent: :destroy
  has_many :comments
  acts_as_reader
  has_many :new_notifications
  # 채팅룸 join 테이블
  has_many :chatroom_users, dependent: :destroy
  # user가 탈퇴해도 메시지 삭제는 되지 않도록 해야함
  # 채팅방 문맥 이해 불가
  has_many :messages
  has_many :chatrooms, through: :chatroom_users
end
