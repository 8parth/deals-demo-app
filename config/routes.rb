Rails.application.routes.draw do
  devise_for :users
  root to: 'deals#index'

  resources :deals
  resources :deal_imports, only: [:index, :create] do
    post 'deals', on: :collection
  end
  resources :pipedrive_tokens, only: [:create]
  delete 'pipedrive_tokens', to: 'pipedrive_tokens#destroy'
end
