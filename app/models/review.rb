class Review < ApplicationRecord
  belongs_to :user
  belongs_to :sauna

  validates :rating, presence: true,
                     inclusion: { in: 1..5 }

  validates :comment, length: { maximum: 500 }, allow_blank: true
end
