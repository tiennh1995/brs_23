class Mark < ActiveRecord::Base
  belongs_to :user
  belongs_to :book
  enum read: [:reading, :mark]
end
