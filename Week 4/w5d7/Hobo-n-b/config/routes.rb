AuthDemo::Application.routes.draw do
  
  root to: "static_pages#home"
  resource :session, only: [:create, :destroy, :new]
  resource :user, only: [:create, :new, :show] do
    resource :counter, only: [:update]
  end
  get '/home' => 'static_pages#home'
  get '/about' => 'static_pages#about'
  get '/contact' => 'static_pages#contact'
  post '/contact' => 'static_pages#create_contact_message'
end
