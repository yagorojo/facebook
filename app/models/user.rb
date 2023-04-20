class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :friendships, foreign_key: "user_id", dependent: :destroy
  has_many :friends, through: :friendships, dependent: :destroy

  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  def full_name
    "#{self.name} #{self.surname}"
  end

  def request_sent?(user)
    friendships.find_by(friend_id: user.id, accepted: false)
  end

  def request_accepted?(user)
    friendships.find_by(friend_id: user.id, accepted: true)
  end

  def request_received?(user)
    Friendship.find_by(user: user, friend: self, accepted: false)
  end

  def friend_requests
    Friendship.where(friend: self, accepted: false)
  end

  def likes?(post)
    likes.exists?(post_id: post.id)
  end
end
