Rails.application.routes.draw do

  devise_for(
    :admins,
    path: 'admin',
    module: 'admin/admins'
  )

  devise_for(
    :customers,
    path: 'customers',
    module: 'public/customers'
  )

  namespace :admin do

    root "homes#top"
    resources :items, except: [:destroy]
    resources :genres, only: [:index, :create, :edit, :update]
  end


  scope module: :public do
    root to: "homes#top"
    resources :items, only: [:index, :show]
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
