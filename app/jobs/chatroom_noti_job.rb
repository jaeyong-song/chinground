class ChatroomNotiJob < ApplicationJob
  queue_as :default

  def perform(chatroom)
    users = chatroom.users
    users.each do |user|
      new_notification = NewNotification.create! user: user,
                        content: "#{chatroom.article.id}글의 채팅이 생성되었습니다",
                        link: "/chatroom/show/#{chatroom.id}"
    end
  end
end
