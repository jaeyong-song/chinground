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
  
  has_many :followed_follows, foreign_key: :follower_id, class_name: "Follow"
  has_many :followeds, through: :followers_follows, source: :follower
  
  has_many :follower_follows, foreign_key: :follwed_id, class_name: "Follow"
  has_many :followers, through: :followeds_follows, source: :followed
  
  def toggle_follow(user)
    if self.follower.include?(user)
      self.follower.delete(user)
    else
      self.follower << user
    end
  end
  
end
