class RegistrationsController < Devise::RegistrationsController
	def new
         flash[:signup] = "Please verify your email after Sign Up"  
    super
  end
  
  def create
    binding.pry
      if User.where(:email => params['user']['email']).present?
        flash[:email] = "Email already registered. Please sign-up with different email" 
        redirect_to action: "new"
      else
        flash[:success] = "Please verify your email." 
        super
      end
  end

  def update
    super
  end
end
