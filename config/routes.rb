Rails.application.routes.draw do
  get   'inquiry'         => 'inquiry#index'     # 入力画面
  post  'inquiry/confirm' => 'inquiry#confirm'   # 確認画面
  post  'inquiry/thanks'  => 'inquiry#thanks'    # 送信完了画面
  get 'rooms/show'
  devise_for :users
  resources :users, only: [:index, :show]
  resources :relationships, only: [:create, :destroy]
  resources :perfumes
  resources :messages, :only => [:create]
  resources :rooms, :only => [:create, :show]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  resources :posts do
    resources :likes, only: [:create, :destroy]
    resources :comments, only: [:create]
  end

  get 'lectures/index'  => 'lectures#index'
  get 'lectures/new'  => 'lectures#new'
  post 'lectures/new'  => 'lectures#create'
  get 'rooms/show' => 'rooms#show'

  root 'posts#index'

end
