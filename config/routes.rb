GetSomeMusic::Application.routes.draw do
  devise_for :users, :path_names => { :sign_up => "register", :sign_in => "login"}

  resources :banddash
  resources :userdash
  resources :admindash

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  root :to => 'home#index'

  # See how all your routes lay out with "rake routes"
end
