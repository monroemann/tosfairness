Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root "websites#index"
  
  get "top_ten_fair", to: "websites#top_ten_fair"
  get "top_ten_unfair", to: "websites#top_ten_fair"
  get "contract_detail", to: "contracts#contract_detail"
  get "contract_list", to: "contracts#contract_list"

end