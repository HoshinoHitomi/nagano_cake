Rails.application.routes.draw do

  devise_for(
    :admins,
    path: 'admin',
    module: 'admin/admins'
  )

  devise_for(
    :customers,
    path: 'customers',
    module: 'public/customers',
    skip: :all
    )
  devise_scope :customer do
    get '/customers/sign_up' => 'public/customers/registrations#new', as: :new_customer_registration
    post '/customers' => 'public/customers/registrations#create', as: :customer_registration

    get '/customers/sign_in' => 'public/customers/sessions#new', as: :new_customer_session
    post '/customers/sign_in' => 'public/customers/sessions#create', as: :customer_session
    delete '/customers/sign_out' => 'public/customers/sessions#destroy', as: :destroy_customer_session
  end

  namespace :admin do

    root "homes#top"

    resources :items, except: [:destroy]
    resources :genres, only: [:index, :create, :edit, :update]
    resources :customers, only: [:index, :show, :edit, :update]
    resources :orders, only: [:show]
  end


  scope module: :public do
    root to: "homes#top"
    get '/about' => "homes#about"

    resources :items, only: [:index, :show]

    resource :customers, only: [:show, :edit, :update]
    get 'customers/confirm' => "customers#confirm", as: :confirm_customers
    patch '/customers' => "customers#withdrawl", as: :withdrawl_customers

    resources :addresses, except: [:new, :show]

    resources :cart_items, only: [:index, :create, :update, :destroy] do
      collection do
        delete 'destroy_all'
      end
    end

    resources :orders, only: [:new, :create, :index]
    post '/orders/confirm' => "orders#confirm", as: :confirm_order
    get '/orders/thanks' => "orders#thanks", as: :thanks_order
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
