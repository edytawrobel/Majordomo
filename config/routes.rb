Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :rooms do
    resources :bookings do
      collection do
        get 'status'
      end
    end
  end
  root 'rooms#index'
end
