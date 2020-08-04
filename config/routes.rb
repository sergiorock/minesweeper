Rails.application.routes.draw do
  devise_for :users
  resources :cells
  resources :games do
    post :reveal, on: :member
    post :flag, on: :member
  end

  root to: "games#index"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
