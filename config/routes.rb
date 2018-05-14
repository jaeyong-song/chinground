Rails.application.routes.draw do
  devise_for :users
  root 'welcome#index'
  
  # =========================================

  # for 'article management'
  get '/article' => 'article#index'
  get '/article/show/:id' => 'article#show'

  get '/article/new' => 'article#new'
  post '/article/create' => 'article#create'
  
  get '/article/destroy/:id' => 'article#destroy'
  
  get '/article/edit/:id' => 'article#edit'
  post '/article/update/:id' => 'article#update'
  get '/article/complete/:id' => 'article#complete'
  
  post '/article/participate/:id' => 'article#participate'
  post '/article/participate_cancel/:id' => 'article#participate_cancel'
  
  # =========================================
  
  # for 'rating management'
  get '/rating' => 'rating#index'
  # get '/rating/show/:id' => 'rating#show'
  
  get '/rating/new/:id' => 'rating#new'
  post '/rating/create/:id' => 'rating#create'

  # 되도록이면 삭제 불가능하도록 해야함...
  # user model에서 has_many: ratings, dependent: :destroy로 상속
  # 따라서 구현 필요 없음..
  # [TODO] 관리자 페이지에서 가능하도록 할 것!
  # get '/rating/destroy/:id' => 'rating#destroy'
  
  # edit도 destroy와 마찬가지
  # 사용자가 수정할 수 있도록 하는 것은 추후에 해야함(시간부족)
  # 대신 알림창으로 수정이 불가능합니다를 미리 알려줄 것
  # [TODO] 관리자 페이지에서 가능하도록 할 것!
  # get '/rating/edit/:id' => 'rating#edit'
  # get '/rating/update'
  
  # =========================================

  # for 'chatroom management'
  get '/chatroom/show'

end