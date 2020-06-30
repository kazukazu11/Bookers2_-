Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root :to => 'homes#home'
  get 'home/about' => 'homes#about'
  resources :users, only: [:show, :edit, :update, :index] do
  	resource :relationships, only: [:create, :destroy]
  	get 'follows' => 'relationships#follower', as: 'follows'
  	get 'followers' => 'relationships#followed', as: 'followers'
  end

  resources :books, only: [:create, :show, :index, :edit, :update, :destroy] do
  	resource :book_comments, only: [:create,:destroy]
  	resource :favorites, only: [:create,:destroy]
  end
  get '/search', to: 'search#search'

  resources :chats, only:[:create,:show]

end
