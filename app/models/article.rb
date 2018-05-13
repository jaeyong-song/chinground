class Article < ApplicationRecord
    belongs_to :user
    has_many :messages, dependent: :destroy
    has_many :ratings # 게시물이 삭제된다고 해서 별점 삭제되면 안됨...
    has_many :article_users, dependent: :destroy
end
