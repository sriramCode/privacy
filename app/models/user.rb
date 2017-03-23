class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  # acts_as_token_authenticatable

  devise :database_authenticatable, :registerable,:confirmable,
       :recoverable, :rememberable, :trackable
  mount_uploader :avatar, AvatarUploader

  has_many :friendships
  has_many :friends,->{where(friendships: {status: 'accepted'})}, :through => :friendships
  has_many :inverse_friendships, :class_name => "Friendship", :foreign_key => "friend_id"
  has_many :inverse_friends, ->{where(friendships: {status: 'accepted'})}, :through => :inverse_friendships, :source => :user   
  validates :username, :presence => true
  has_and_belongs_to_many :images
  has_and_belongs_to_many :posts
  has_many :posted, :through => :posts
  has_many :images, as: :imageable, :dependent => :destroy
  has_many :owners, :through => :images
  has_many :permissions
end
