Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root "websites#index"

  resources :companies do
    get :autocomplete_company_company_name, :on => :collection
    resources :contracts
  end

  resources :contracts

  resources :contract_user_ratings, only: [:index, :show, :new, :create]
  resources :user_loggings, only: [:index, :show, :new, :create]

  get "top_ten_fair", to: "websites#top_ten_fair"
  get "top_ten_unfair", to: "websites#top_ten_unfair"
  get "contract_detail", to: "contracts#contract_detail"
  get "contract_list", to: "contracts#contract_list"
  get "bill_of_rights", to: "websites#bill_of_rights"
  get "rating_system", to: "websites#rating_system"
  get "volunteer", to: "websites#volunteer"
  get "about", to: "websites#about"
  get "break_diving", to: "websites#break_diving"
  get "donate", to: "websites#donate"

end
