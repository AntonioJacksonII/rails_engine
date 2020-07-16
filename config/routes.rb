Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      get '/merchants/find', to: 'merchants_search#show'
      get '/merchants/find_all', to: 'merchants_search#index'

      get '/merchants/most_revenue', to: 'business_intelligence#index'
      get '/merchants/most_items', to: 'business_intelligence#index'
      get '/merchants/:id/revenue', to: 'business_intelligence#index'

      resources :merchants do
        get '/items', to: 'merchant_items#index'
      end

      resources :items
    end
  end
end
