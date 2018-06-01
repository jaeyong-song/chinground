class RejectFreechat < ApplicationRecord
  belongs_to :user
  belongs_to :freechat
end
