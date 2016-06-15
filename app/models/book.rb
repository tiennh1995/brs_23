class Book < ActiveRecord::Base
  belongs_to :category

  has_many :reviews
  has_many :marks
end
