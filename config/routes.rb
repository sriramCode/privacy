Rails.application.routes.draw do

  #get 'images/picture:string'

  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users, :controllers => {:registrations => "registrations",  :confirmations => 'confirmations'}

  root to: 'homes#index'
  resources :images
  resources "homes" do
  collection do
    get 'get' 
    post 'add_friend'
    post 'accept_friend'
    post 'set_privacy'
    post 'add_post'
    post 'add_image'
    post 'approve'
  end
end

end
