Rails.application.routes.draw do
  resources :recurrent_cards
  resources :labels
  resources :analyses
  resources :lists
  resources :boards do
    get "/:id/execute_recurrent_cards", to: "boards#execute_recurrent_cards", on: :collection, as: "execute_recurrent_cards"
  end
  resources :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "home#index"
end
