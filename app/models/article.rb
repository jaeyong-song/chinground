class Article < ApplicationRecord
    belongs_to :user
    has_many :ratings # 게시물이 삭제된다고 해서 별점 삭제되면 안됨...
    has_many :article_users, dependent: :destroy
    has_many :comments, dependent: :destroy
    has_one :chatroom
end
