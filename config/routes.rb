Rails.application.routes.draw do
  get 'chatroom/show'

  devise_for :users
  root 'welcome#index'

  get '/article' => 'article#index'
  get '/article/show/:id' => 'article#show'

  get '/article/new' => 'article#new'
  post '/article/create' => 'article#create'
  
  get '/article/destroy/:id' => 'article#destroy'
  
  get '/article/edit/:id' => 'article#edit'
  post '/article/update/:id' => 'article#update'
end