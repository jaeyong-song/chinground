class FreechatUser < ApplicationRecord
  belongs_to :freechat
  belongs_to :user
end
