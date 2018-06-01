class Article < ApplicationRecord
    belongs_to :user
    has_many :ratings # 게시물이 삭제된다고 해서 별점 삭제되면 안됨...
    has_many :article_users, dependent: :destroy
    has_many :joined_users, through: :article_users, source: :user
    has_many :comments, dependent: :destroy
    has_one :chatroom
    
    # 밴 구현(게시물)
    has_many :ban_articles, dependent: :destroy
    has_many :banned_users, through: :ban_articles, source: :user
end
