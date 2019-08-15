Rails.application.routes.draw do
  devise_for :users, ActiveAdmin::Devise.config
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
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
  delete 'user/cart/remove_product' => 'orders#remove_ordered_product'
  patch 'user/order/submit' => 'orders#submit'
  get 'admin/order/index' => 'orders#index'
  delete 'user/order/delete' => 'orders#delete'
  get 'admin/discounts/index' => 'discounts#index'
  post 'admin/discounts/create' =>'discounts#create'

  # devise_for :users, controllers: {
  #     sessions: 'users/sessions',
  #     registrations: 'users/registrations',
  #     passwords: 'users/passwords',
  # }

  devise_scope :user do
    get 'current' => 'users/sessions#current'
  end

end
