NaganoComfort::Application.routes.draw do

  namespace :client do
    resources :bedrooms, :transactions, only: [:index, :show]
    resources :reservations, only: [:index, :show, :new, :create]
    resources :bedrooms do
      member do
        get :check_availability
        post :check_availability
      end
    end
  end

  namespace :admin do
    resources :bedrooms, :customers, :price_variations, :reservations, :transactions
    resources :bedroom_statuses, :bedroom_types, :view_types, only: [:index, :new, :create, :edit, :update, :destroy]
  end

  root :to => 'pages#home'
end
