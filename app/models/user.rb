class User < ActiveRecord::Base
  has_many :marks, dependent: :destroy
  has_many :activities, dependent: :destroy
  has_many :reviews, dependent: :destroy
  has_many :requests, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :liked_activities, through: :likes, source: :activity
  has_many :microposts, dependent: :destroy
  has_many :active_relationships, class_name: Follow.name,
                                   foreign_key: "follower_id",
                                   dependent: :destroy
  has_many :passive_relationships, class_name: Follow.name,
                                   foreign_key: "followed_id",
                                   dependent: :destroy
  has_many :following, through: :active_relationships, source: :followed
  has_many :followers, through: :passive_relationships, source: :follower
  has_secure_password

  def remember
    self.remember_token = User.new_token
    update_attributes remember_digest: User.digest(remember_token)
  end

  def authenticated? attribute token
    digest = send "#{attribute}_digest"
    return false if digest.nil?
    BCrypt::Password.new(digest).is_password? token
  end

  def forget
    update_attributes remember_digest: nil
  end

  class << self
    def digest string
      cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MINCOST :
        BCrypt::Engine.cost
      BCrypt::Password.create string, cost: cost
    end

    def new_token
      SecureRandom.urlsafe_base64
    end
  end
end
