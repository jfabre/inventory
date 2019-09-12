Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  #
  
  root to: 'home#index'
  get '/inventory.json', to: 'home#inventory'
  mount ActionCable.server => '/cable'
end
