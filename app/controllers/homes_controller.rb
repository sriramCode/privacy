class HomesController < ApplicationController
	before_action :authenticate_user!
	
	def index

	end

	def get
		addFriends = User.all - (current_user.friends + current_user.inverse_friends) - [current_user]
		friends = current_user.friends + current_user.inverse_friends
		requests = []
		current_user.inverse_friendships.where(:status => 'pending').each do |req|
			requests << User.find(req.user_id)  
		end  
		permissions = Permission.where(:user_id => current_user.id,:status => "no")
		posts = []
		images = []
		
		friends.each do |p|
			Post.where(:posted_id => p.id).each do |o|
				if Permission.find_by(:post_id => o.id) != nil
					check = Permission.where(:post_id => o.id)
					status = true
					check.each do |c|
						if c.status == "no"
							status = false
						end
					end
					if status
						posts << o
					end
				else
					posts << o
				end
			end
			Image.where(:imageable_id => p.id).each do |o|
				if Permission.find_by(:image_id => o.id) != nil
					check = Permission.where(:image_id => o.id)
					status = true
					check.each do |c|
						if c.status == "no"
							status = false
						end
					end
					if status
						images << o
					end
				else
					images << o
				end
			end
		end
		images = images.to_json(:include => :owner)
		posts = posts.to_json(:include => :posted)
		permissions = permissions.to_json(:include => {:post =>{:include => :posted}})

		render json: {addFriends: addFriends, current_user: current_user, friends: friends, requests: requests, posts: posts,images: images, permissions: permissions}
	end

	def add_friend
		Friendship.create(:user_id => current_user.id,:friend_id => params['friend_id'],:status => "pending")
	end

	def accept_friend
		Friendship.find_by(:user_id => params['user_id'],:friend_id => current_user.id).update(:status => "accepted")
	end

	def set_privacy
		User.find(current_user.id).update(:privacy => params['privacy'])
	end

	def add_post
		post = Post.create(:posted_id => current_user.id,:post => params['post'])
		params['assignedUser'].each do |user|
			if current_user.privacy == "all"
				if User.find_by(:email => user).privacy == "friends"
   					post.users << User.find_by(:email => user)
   					Permission.create(:user_id => User.find_by(:email => user).id, :post_id => post.id, :status => "no")
   				end
   				if User.find_by(:email => user).privacy == "me"
   					post.users << User.find_by(:email => user)
   					Permission.create(:user_id => User.find_by(:email => user).id, :post_id => post.id, :status => "no")
   				end
   			end

   			if current_user.privacy == "friends"
   				if User.find_by(:email => user).privacy == "friends"
   					post.users << User.find_by(:email => user)
   					Permission.create(:user_id => User.find_by(:email => user).id, :post_id => post.id, :status => "no")
   				end
   				if User.find_by(:email => user).privacy == "me"
   					post.users << User.find_by(:email => user)
   					Permission.create(:user_id => User.find_by(:email => user).id, :post_id => post.id, :status => "no")
   				end
   			end
		end 
	end

	def approve
		Permission.find(params['permission_id']).update(:status => "yes")
	end


end
