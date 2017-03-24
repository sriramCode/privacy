class ImagesController < ApplicationController

	def create
		image = current_user.images.create(:avatar => params['image']['avatar'],:owner_id => current_user.id)
		params['image']['assignedUser'].each do |user|
			if current_user.privacy == "all"
				if User.find_by(:email => user).privacy == "friends"
   					image.users << User.find_by(:email => user)
   					Permission.create(:user_id => User.find_by(:email => user).id, :image_id => image.id, :status => "no")
   				end
   				if User.find_by(:email => user).privacy == "me"
   					image.users << User.find_by(:email => user)
   					Permission.create(:user_id => User.find_by(:email => user).id, :image_id => image.id, :status => "no")
   				end
   			end
   			if current_user.privacy == "friends"
   				if User.find_by(:email => user).privacy == "friends"
   					image.users << User.find_by(:email => user)
   					Permission.create(:user_id => User.find_by(:email => user).id, :image_id => image.id, :status => "no")
   				end
   				if User.find_by(:email => user).privacy == "me"
   					post.users << User.find_by(:email => user)
   					Permission.create(:user_id => User.find_by(:email => user).id, :image_id => image.id, :status => "no")
   				end
   			end
		end 
	end
end
