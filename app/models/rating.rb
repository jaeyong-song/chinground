class Rating < ApplicationRecord
    # [CHK] rating 5점이하 제한 조건 걸 것!
    validates :less, numericality: { less_than: 5 }
    validates :larger, numericality: { greater_than: 0 }
    belongs_to :user
    belongs_to :article
end