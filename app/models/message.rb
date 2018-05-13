class Message < ApplicationRecord
  after_create_commit { MessageBroadcastJob.perform_later self }
  #belongs_to :user
  #belongs_to :article
  #[TODO] user_id 및 article_id 삽입 가능케 한 후 주석 풀 것!!
end
