Rails.application.routes.draw do
  root to: "urls#index"
  resources :urls, only: [:index, :create]
  get "/:shortened", to: "shortened_urls#show", as: "short_url"
end
