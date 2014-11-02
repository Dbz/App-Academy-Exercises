Rails.application.routes.draw do
  resources :users, only: [:show, :create, :new, :update]
  resource :session, only: [:create, :new, :destroy]
  resources :subs do
    resources :posts, execpt: [:index, :show]
  end
  root to: 'subs#index'
end
