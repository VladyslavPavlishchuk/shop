Rails.application.routes.draw do
  root to: 'pages#home'

  get '/admin/users' => 'users_administration#show'
  post '/admin/users' => 'users_administration#edit'
  patch '/admin/users' => 'users_administration#edit'

  devise_for :users, controllers: {
      sessions: 'users/sessions',
      registrations: 'users/registrations',
      passwords: 'users/passwords'
  }
end
