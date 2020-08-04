Rails.application.routes.draw do
  resources :cells
  resources :games do
    post :reveal, on: :member
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
