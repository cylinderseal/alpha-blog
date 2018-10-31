Rails.application.routes.draw do
  get 'articles/new'
  root 'pages#home'
  get  '/about', to: "pages#about"
  resources :articles
end
