class Rating < ApplicationRecord
    # [TODO] rating 5점이하 제한 조건 걸 것!
    belongs_to :user
    belongs_to :article
end