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
  
  has_many :freechat_users, dependent: :destroy
  has_many :free_messages # 사람이 탈퇴해도 메시지는 남아있어요
  has_many :freechats, through: :freechat_users
  
  has_many :followee_follows, foreign_key: :follower_id, class_name: "Follow"
  has_many :followees, through: :followee_follows, source: :followee
  
  has_many :follower_follows, foreign_key: :followee_id, class_name: "Follow"
  has_many :followers, through: :follower_follows, source: :follower
  
  def toggle_follow(user)
    if self == user
      return -1 # 본인과는 친구가 될 수 없으므로 -1 반환
    end
    if self.followees.include?(user)
      self.followees.delete(user)
      return 0 # 관계 삭제시 0 반환
    else
      self.followees << user
      return 1 # 관계 형성 시 1 반환
    end
  end
  
end
