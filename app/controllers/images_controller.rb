class ImagesController < ApplicationController

	def create
		 current_user.images.create(:avatar => params['image']['avatar'],:owner_id => current_user.id)
	end
  
end
