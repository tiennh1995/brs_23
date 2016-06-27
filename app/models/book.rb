class Book < ActiveRecord::Base
  belongs_to :category

  has_many :reviews
  has_many :marks

  validates :category_id, presence: true
  validates :title, presence: true, length: {maximum: 250}
  validates :author, presence: true, length: {maximum: 250}
  validates :pages, presence: true, length: {maximum: 6},
    numericality: {only_integer: true}
  mount_uploader :picture, PictureUploader
  scope :search_by, ->(search) {where "title LIKE ? OR publish_date = ?
    OR author LIKE ? OR pages = ?",
    "%#{search}%", "#{search}", "%#{search}%", "#{search}"}

  def average_rate
    Review.where(book_id: self.id).average(:rated).to_f
  end

  class << self
    def search search
      search ? search_by(search) : Book.all
    end

    def average_rates
      books = Book.all
      rateds = Hash.new
      books.each do |book|
        rateds[book.id] = book.average_rate
      end
      rateds
    end
  end
end
