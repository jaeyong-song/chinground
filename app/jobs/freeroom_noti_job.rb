class FreeroomNotiJob < ApplicationJob
  queue_as :default

  def perform(freeroom)
    users = freeroom.users
    users.each do |user|
      new_notification = NewNotification.create! user: user,
                        content: "#{freeroom.id}번 자유채팅이 생성되었습니다",
                        link: "/freechats/show/#{freeroom.id}"
    end
  end
end
