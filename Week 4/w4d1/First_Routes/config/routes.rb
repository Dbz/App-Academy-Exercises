Rails.application.routes.draw do
  resources :users, only: [
    :index,
    :show,
    :update,
    :destroy,
    :create
    ] do
      resources :contacts, only: :index
      end
      
  
  resources :contacts, only: [
    :show,
    :update,
    :destroy,
    :create
  ]
  
  resources :contact_shares, only: [
    :create,
    :destroy
  ]
  
  
end
