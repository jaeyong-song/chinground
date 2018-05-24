class ChatroomUser < ApplicationRecord
  belongs_to :user
  belongs_to :chatroom
  # 한 채팅방에 그 사람은 한번의 join만 가능하도록 uniq 설정
  validates_uniqueness_of :user_id, :scope => :chatroom_id
  validates_presence_of :user_id
  validates_presence_of :chatroom_id
end
