class Post < ApplicationRecord
	belongs_to :posted, :class_name => 'User'
	has_and_belongs_to_many :users
end
