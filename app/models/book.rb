class Book < ActiveRecord::Base
  belongs_to :category

  has_many :reviews
  has_many :marks

  validates :category_id, presence: true
  validates :title, presence: true, length: {maximum: 250}
  validates :author, presence: true, length: {maximum: 250}
  validates :pages, presence: true, length: {maximum: 6},
    numericality: {only_integer: true}
  scope :search_by, ->(search) {where "title LIKE ? OR publish_date = ?
    OR author LIKE ? OR pages = ?",
    "%#{search}%", "#{search}", "%#{search}%", "#{search}"}

  class << self
    def search search
      search ? search_by(search) : Book.all
    end
  end
end
