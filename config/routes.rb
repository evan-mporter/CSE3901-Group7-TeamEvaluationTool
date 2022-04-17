Rails.application.routes.draw do
  resources :projects
  resources :groups
  get 'students/login', to: 'students#login'
  delete 'students/logout', to: 'students#logout'
  get 'students/email', to: 'students#email'
  post 'students/email', to: 'students#emailchecker'
  get 'students/signup', to: 'students#signup'
  get 'student/login/:id', to: 'students#login_process'
  post 'student/login/:id', to: 'students#check'
  get 'student/:id/edit/:mode', to: 'students#edit'
  get 'student/:id/:mode', to: 'students#show'
  
  resources :students, :except => [:edit, :show]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  # Instructor routes
  get 'instructors/login', to: 'instructors#login'
  get 'instructor/login/:id', to: 'instructors#login_process'
  post 'instructor/login/:id', to: 'instructors#check'
  get 'instructors/logout', to: 'instructors#logout'
  get 'instructors/signup', to: 'instructors#signup'
  get 'instructors/email', to: 'instructors#email'
  post 'instructors/email', to: 'instructors#emailchecker'
  get 'instructor/:id/edit', to: 'instructors#edit'
  get 'instructor/:id', to: 'instructors#show'

  resources :instructors

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
