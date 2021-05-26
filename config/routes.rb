Rails.application.routes.draw do
  root 'sessions#new'
  get '/signup', to: 'users#new'
  
  get '/login', to:'sessions#new'
  post '/login', to:'sessions#create'
  delete '/logout', to:'sessions#destroy'
  
  resources :users do
    member do
      get 'edit_basic_info'
      patch 'update_basic_info'
      get 'attendances/edit_one_month'
      patch 'attendances/update_one_month'
    end
    resources :articles do
      member do
        get 'edit_news_info'
        patch 'update_news_info'
      end
    end
    resources :reservations do
      member do
          get 'edit_area_info'
          patch 'update_area_info'
          patch 'close_info'
      end
      member do
        resources :attendances do
          get 'edit_order_info'
          patch 'update_order_info'
        resources :attendances, param: :date

        end
      end
    end
  end
end
