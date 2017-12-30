Rails.application.routes.draw do
  match '/' => 'repositories#index', :as => :root, via: :get
  match '/create' => 'repositories#create', as: :create, via: :post
  match '/show' => 'repositories#show', as: :show, via: :get
  match '/packages' => 'repositories#packages', as: :packages, via: :get
  resources :repositories
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
