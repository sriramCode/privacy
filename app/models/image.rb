class Image < ApplicationRecord
	mount_uploader :avatar, AvatarUploader
	has_and_belongs_to_many :users
	belongs_to :imageable, polymorphic:true
	belongs_to :owner, :class_name => 'User'
	has_many :permissions
end
