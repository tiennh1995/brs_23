class Review < ActiveRecord::Base
  has_many :comments

  belongs_to :user
  belongs_to :book
  validates :content, presence: true
  validates :rated, presence: true
end
