class User < ActiveRecord::Base
  has_many :marks, dependent: :destroy
  has_many :activities, dependent: :destroy
  has_many :reviews, dependent: :destroy
  has_many :requests, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :liked_activities, through: :likes, source: :activity
  has_many :comments, dependent: :destroy
  has_many :active_relationships, class_name: Follow.name,
                                  foreign_key: "follower_id",
                                  dependent: :destroy
  has_many :passive_relationships, class_name: Follow.name,
                                   foreign_key: "followed_id",
                                   dependent: :destroy
  has_many :following, through: :active_relationships, source: :followed
  has_many :followers, through: :passive_relationships, source: :follower
  validates :fullname, presence: true, length: {maximum: 50}
  validates :email, presence: true, length: {maximum: 255},
    format: {with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i}, uniqueness: true
  has_secure_password
  validates :password, presence: true, length:{minimum: 6}
  mount_uploader :avatar, AvatarUploader
  before_save :downcase_email
  scope :activity, ->(user){Activity.where "user_id IN (SELECT followed_id FROM
    follows WHERE follower_id = :user_id) OR user_id = :user_id", user_id: user.id}
  attr_accessor :remember_token

  def remember
    self.remember_token = User.new_token
    update_attributes remember_digest: User.digest(remember_token)
  end

  def authenticated? attribute, token
    digest = send "#{attribute}_digest"
    return false if digest.nil?
    BCrypt::Password.new(digest).is_password? token
  end

  def forget
    update_attributes remember_digest: nil
  end

  def follow other_user
    active_relationships.create followed_id: other_user.id
  end

  def unfollow other_user
    active_relationships.find_by(followed_id: other_user.id).destroy
  end

  def following? other_user
    following.include? other_user
  end

  def favorite? book_id
    marks.find_by(book_id: book_id, is_favorite: true).present?
  end

  def was_read? book_id
    mark = marks.find_by book_id: book_id
    mark.present? ? mark.read? : false
  end

  def like? activity_id
    return Like.find_by(user_id: id, activity_id: activity_id).present?
  end

  def activity
    Activity.activity id
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

  private
  def downcase_email
    self.email = email.downcase
  end
end
