Rails.application.routes.draw do


  root 'users#index'



  resources :users do
    collection do
      get :search
      put 'approve_multiple'
      put 'reject_multiple'
      get :filter_by_payment

    end
  end
  resources :users, only: %i(new create show edit)

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
