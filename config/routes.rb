Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root :to => "homes#top"
  get "home/about" => "homes#about"
  post 'follow/:id' => 'relationships#follow', as: 'follow' # フォローする
  post 'unfollow/:id' => 'relationships#unfollow', as: 'unfollow' # フォロー外す
  get 'followers' => 'relationships#followers', as: 'followers'
  get 'followings' => 'relationships#followings', as: 'followings'
  
  resources :books, only: [:index, :show, :edit, :create, :destroy, :update] do
    resource :favorites, only: [:create, :destroy]
    resources :book_comments, only: [:create, :destroy]
  end
  
  
  resources :users, only: [:index, :show, :edit, :update] 
  # do
  #   resource :relationships, only: [:create, :destroy]
  # end
  
  

end
