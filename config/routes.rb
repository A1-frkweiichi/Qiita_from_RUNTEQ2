Rails.application.routes.draw do
  root "top#top"

  get "up" => "rails/health#show", as: :rails_health_check
  get 'keep_awake', to: 'application#keep_awake'
end
