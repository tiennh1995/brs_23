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
  scope :search_with_string, ->(search, column) {where "#{column} LIKE ?",
    "%#{search}%"}
  scope :search_with_category, ->(search, column) {where "category_id IN
    (SELECT id FROM categories WHERE name LIKE ?)", "%#{search}%"}
  scope :search_with_, ->(search, column) {all}

  class << self
    def search search, column
      if column == "title" || column == "author"
        type = "string"
      else
        type = column
      end
      send "search_with_#{type}", search, column
    end

    def column_search
      a = ["id", "created_at", "updated_at", "pages", "rated", "publish_date",
        "picture"]
      Book.column_names - a
    end
  end
end
