class Permission < ApplicationRecord
	belongs_to :user
	belongs_to :post
	belongs_to :image
end
