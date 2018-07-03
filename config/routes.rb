Rails.application.routes.draw do
  get 'votes/create'

  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root "websites#index"

  resources :companies do
    get :autocomplete_company_company_name, :on => :collection
    resources :contracts
    resources :votes
  end

  resources :contracts do
    resources :contract_revisions
  end

  resources :contract_user_ratings
  resources :user_loggings, only: [:index, :show, :new, :create]
  resources :update_requests

  get "top_ten_fair", to: "websites#top_ten_fair"
  get "top_ten_unfair", to: "websites#top_ten_unfair"
  get "latest_reviews", to: "websites#latest_reviews"
  get "contract_detail", to: "contracts#contract_detail"
  get "contract_list", to: "contracts#contract_list"
  get "bill_of_rights", to: "websites#bill_of_rights"
  get "rating_system", to: "websites#rating_system"
  get "volunteer", to: "websites#volunteer"
  get "about", to: "websites#about"
  get "team", to: "websites#team"
  get "break_diving", to: "websites#break_diving"
  get "terms", to: "websites#terms"
  get "donate", to: "websites#donate"
  get "index", to: "websites#index"

end
