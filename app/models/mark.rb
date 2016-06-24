class Mark < ActiveRecord::Base
  belongs_to :user
  belongs_to :book
  enum read: [:nothing, :reading, :read]
  scope :read_or_reading, ->{where.not read: "nothing"}
  scope :loved, ->{where is_favorite: true}
end
