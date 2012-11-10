GetSomeMusic::Application.routes.draw do
  
  post "transactions/notify"
  get "transactions/show"
  get "transactions/subscribe"
  get "albums/create"
  get "albums/destroy"
  get "albums/view"
  get "songs/create"
  get "songs/destroy"
  get "songs/edit"
  get "songs/update"
  get "credits/create"
  get "credits/update"
  get "purchases/create"
  get "purchases/displayall"
  get "purchases/destroy"
  get "banddash/destroy"
  get "home/index"
  get "home/download"
  get "home/search"
  
  
  devise_for :users, :path_names => { :sign_up => "register", :sign_in => "login"}
  
  
  resources :users do
    resources :purchases, :only => [:create, :destroy]
    resources :band, :only => [:create, :destroy] 
  end
  
  resources :albums
  resources :credits
  resources :songs
  resources :transactions
  
  resources :banddash, :only => [:index, :create, :destroy]
  resources :userdash, :only => [:index]
  resources :admindash, :only => [:index]
  
  root :to => 'home#index'
end
