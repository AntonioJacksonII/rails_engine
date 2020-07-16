Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      get '/merchants/find', to: 'merchants#show'
      resources :merchants do
        resources :items, only: [:index]
      end
    end
  end
end
