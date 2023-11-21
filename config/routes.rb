Rails.application.routes.draw do
  devise_for :customers,skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }


  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
    sessions: "admin/sessions"
  }

  namespace :admin do
    root to: 'homes#top'
    get "search" => "searches#search"
    resources :orders, only: [:show, :update]
    resources :customers, only: [:index, :show, :edit, :update]
    resources :genres, only: [:index, :create, :edit, :update]
    resources :items, except: [:destroy]
    resources :order_details, only: [:update]
  end
  scope module: :public do
    root to: 'homes#top'
    get "search" => "searches#search"
    get '/about'=>'homes#about'
    resources :shipping_addresses, only: [:index, :edit, :create, :update, :destroy]
    resources :orders, only: [:new, :create, :index, :show] do
      collection do
        get :complete
        post :confirm
      end
    end
    resources :cart_items, only: [:index, :update, :destroy, :create] do
      collection do
        delete :destroy_all
      end
    end
    resources :customers, only: [:show, :edit, :update] do
      collection do
        get :confirm
        patch :withdrawal
      end
    end
    resources :items, only: [:index, :show]
  end
end
