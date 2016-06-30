class Review < ActiveRecord::Base
  has_many :comments

  belongs_to :user
  belongs_to :book
  validates :content, presence: true
  validates :rated, presence: true, inclusion: {in: 1..5}
  scope :order_review, ->{order created_at: :desc}

  after_save do
    self.book.update_attributes rated: self.average_rate(self.book.id)
  end

  def average_rate book_id
    Review.where(book_id: book_id).average(:rated).to_f
  end

  class << self
    def rateds
      rated = [1, 2, 3, 4, 5]
    end
  end
end
