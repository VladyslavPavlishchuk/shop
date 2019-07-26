Rails.application.routes.draw do
  root to: 'pages#home'

  get '/admin/users' => 'users_administration#show'
  post '/admin/users' => 'users_administration#edit'
  patch '/admin/users' => 'users_administration#edit'

  get '/admin/products' => 'admin_products#show'
  post '/admin/products' => 'admin_products#create'
  patch '/admin/products' => 'admin_products#create'
  delete '/admin/products' => 'admin_products#delete'

  get '/admin/categories' => 'admin_categories#show'
  post '/admin/categories' => 'admin_categories#create'
  patch '/admin/categories' => 'admin_categories#create'
  delete '/admin/categories' => 'admin_categories#delete'

  get 'pages/page'

  devise_for :users, controllers: {
      sessions: 'users/sessions',
      registrations: 'users/registrations',
      passwords: 'users/passwords'
  }
end
