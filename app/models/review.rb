class Review < ActiveRecord::Base
  has_many :comments

  belongs_to :user
  belongs_to :book
  validates :content, presence: true
  validates :rated, presence: true, inclusion: {in: 1..5}
  scope :order_review, ->{order created_at: :desc}
end
