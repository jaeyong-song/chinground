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
end
