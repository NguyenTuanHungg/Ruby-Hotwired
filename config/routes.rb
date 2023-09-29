Rails.application.routes.draw do


  root 'users#index'

  delete 'users/:id', to: 'users#destroy'


  resources :users,path: 'mentors' do
    collection do
      get :search
      put 'approve_multiple'
      put 'reject_multiple'
      get :filter_by_payment
      get :filter_by_date
      get :filter_by_status
    end
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
