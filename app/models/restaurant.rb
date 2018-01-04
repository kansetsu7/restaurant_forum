class Restaurant < ApplicationRecord
  validates_presence_of :name
  mount_uploader :image, PhotoUploader
  belongs_to :category, optional: true
  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :favorited_users, through: :favorites, source: :user
  has_many :likes, dependent: :destroy
  has_many :liked_users, through: :likes, source: :user
  delegate :name, to: :category, prefix: true, allow_nil: true

  def is_favorited?(user)
    self.favorited_users.include?(user)
  end
  
  def is_liked?(user)
    self.liked_users.include?(user)
  end

end
