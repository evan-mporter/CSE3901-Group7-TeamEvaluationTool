Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  # Instructor routes
  resources :instructors

  # Student routes
  resources :students

  # Group routes

  # Evaluations routes

  # Application routes
  root 'application#root'
  get '/login', to: 'application#login'

  # Handle test reset, to make testing the app on Heroku possible
  get '/full-system-reset-for-testing-only', to: 'application#full_reset'
  post '/full-system-reset-for-testing-only', to: 'application#do_full_reset'
end
