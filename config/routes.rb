Rails.application.routes.draw do
  get 'students/login', to: 'students#login'
  delete 'students/logout', to: 'students#logout'
  get 'students/email', to: 'students#email'
  post 'students/email', to: 'students#emailchecker'
  post 'students/instructors_new', to: 'students#instructor_new'
  get 'students/signup', to: 'students#signup'
  get 'students/login/:id', to: 'students#login_process'
  post 'students/login/:id', to: 'students#check'
  
  resources :students
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  # Instructor routes
  resources :instructors
  get '/instructors/login', to: 'instructor#display_login', as: :instructor_display_login
  post '/instructors/login', to: 'instructor#login', as: :instructor_login

  # Student routes
  resources :students

  # Group routes

  # Evaluations routes
  get '/evaluations/:group/:project', to: 'evaluations#landing', as: :begin_eval
  get '/evaluations/:group/:project/done', to: 'evaluations#done', as: :done_eval
  get '/evaluations/:group/:project/:member', to: 'evaluations#single', as: :continue_eval

  # Application routes
  root 'application#root'
  get '/login', to: 'application#login'

  # Handle test reset, to make testing the app on Heroku possible
  get '/full-system-reset-for-testing-only', to: 'application#full_reset'
  post '/full-system-reset-for-testing-only', to: 'application#do_full_reset'
end
