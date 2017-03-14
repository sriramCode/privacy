class HomesController < ApplicationController
	before_action :authenticate_user!
	def index

	end

	def get
		addFriends = User.all - (current_user.friends + current_user.inverse_friends) - [current_user]
		friends = current_user.friends
		requests = []
		current_user.inverse_friendships.where(:status => 'pending').each do |req|
			requests << User.find(req.user_id)  
		end  
		posts = []
		
		friends.each do |p|
			Post.where(:posted_id => p.id).each do |o|
				posts << o.post
			end
		end
		binding.pry
		render json: {addFriends: addFriends, current_user: current_user, friends: friends, requests: requests}.to_json(:includes => :user)
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
   			post.users << User.find_by(:email => user)
		end 
	end

end
