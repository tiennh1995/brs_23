class Activity < ActiveRecord::Base
  belongs_to :user
  has_many :likes
  enum activity_type: [:follow, :markread, :markfav, :writereview, :writecomment]

  scope :activity, ->(id){where "user_id IN (SELECT followed_id FROM follows
    WHERE follower_id = :user_id) OR user_id = :user_id", user_id: id}

  scope :order_by_time, ->{order created_at: :desc}

  class << self
    def list_book activities
      arr = activities.map {|activity| activity.action_id }
      Book.where "id IN (?)", arr
    end

    def list_user activities
      arr = activities.map {|activity| activity.action_id }
      User.where "id IN (?)", arr
    end
  end
end
