class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :comments, dependent: :nullify
  has_many :restaurants, through: :comments
  has_many :favorites, dependent: :destroy
  has_many :favorited_restaurants, through: :favorites, source: :restaurant
  has_many :likes, dependent: :destroy
  has_many :liked_restaurants, through: :likes, source: :restaurant
  has_many :followships
  has_many :followings, through: :followships
  has_many :inverse_followships, class_name: "Followship", foreign_key: "following_id"
  has_many :followers, through: :inverse_followships, source: :user
  has_many :friendships
  has_many :friends, through: :friendships
  has_many :inverse_friendships, class_name: "Friendship", foreign_key: "friend_id"
  has_many :invers_friends, through: :inverse_friendships, source: :user
  before_save :ini_name

  mount_uploader :avatar, AvatarUploader
  def admin?
    self.role == "admin"
  end

  def ini_name
    if self.name == ""
      self.name = self.email.split('@').first
    end
  end

  def is_following?(user)
    self.followings.include?(user)
  end

  def friend?(user)
    self.friends.include?(user)
  end

  def all_friends()
    (self.invers_friends + self.friends).uniq
  end

  # request form user
  def waiting_confirms
    self.friendships.where("confirmed = ?", false)
  end

  # friend request from others
  def need_confirms
    self.inverse_friendships.where("confirmed = ?", false)
  end

end
