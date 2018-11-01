Rails.application.routes.draw do
  get    'sessions/new'
  get    'articles/new'
  root   'pages#home'
  get    '/about',  to: "pages#about"
  resources :articles
  get    '/signup', to: 'users#new'
  resources :users, except: [:new]
  get    '/login',  to: 'sessions#new'
  post   '/login',  to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
end
