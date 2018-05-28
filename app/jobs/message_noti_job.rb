class MessageNotiJob < ApplicationJob
  queue_as :default

  def perform(message)
    # 메시지 생성 후 참여인원 등에게 알림
    article = message.chatroom.article
    user_list = ArticleUser.where(article_id: article.id)
    users = []
    user_list.each do |user|
      users << user.user_id
    end
    users.each do |user|
      new_notification = NewNotification.create! user: User.find(user),
                          content: "#{message.chatroom.id}글의 채팅에 #{message.user.email}님이 말했습니다",
                          link: "/chatroom/show/#{message.chatroom.id}"
    end
  end
end
