Rails.application.routes.draw do
  root to: 'pages#index'

  get '/admin/users' => 'users_administration#index'
  post '/admin/users' => 'users_administration#update'
  patch '/admin/users' => 'users_administration#update'

  get '/admin/products' => 'admin_products#index'
  get '/admin/products/show' => 'admin_products#show'
  get '/admin/products/newest' => 'admin_products#newest'
  post '/admin/products' => 'admin_products#create'
  patch '/admin/products' => 'admin_products#update'
  delete '/admin/products' => 'admin_products#delete'

  get '/admin/categories' => 'admin_categories#index'
  get '/admin/categories/newest' => 'admin_categories#newest'
  post '/admin/categories' => 'admin_categories#create'
  patch '/admin/categories' => 'admin_categories#update'
  delete '/admin/categories' => 'admin_categories#delete'

  get '/user/cart' => 'orders#show'

  get 'pages/page'
  get 'pages/products' => 'user_products#index'
  post 'ordered_products' => 'orders#create'

  devise_for :users, controllers: {
      sessions: 'users/sessions',
      registrations: 'users/registrations',
      passwords: 'users/passwords',
  }

  devise_scope :user do
    get 'current' => 'users/sessions#current'
  end

end
