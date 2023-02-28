Rails.application.routes.draw do
  get 'private/test'
  get '/current_user', to: 'current_user#index'

  devise_for :users, path: '', path_names: {
        sign_in: 'login',
        sign_out: 'logout',
        registration: 'signup'
      },
      controllers: {
        sessions: 'users/sessions',
        registrations: 'users/registrations'
      }


  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      get 'program_leaderboard', to: 'program_trackers#current_program_impact'
      get 'program_trackers/:id/current_day', to: 'program_trackers#current_dwt'
      get 'program_trackers/:id/five_day_array', to: 'program_trackers#five_day_array'
      resources :users, only: [ :index, :show, :update, :destroy]
      # get '/users', to: 'users#index'
      # get '/users/:id', to: 'users#show'
      # patch '/users/:id', to: 'users#update'
      get 'users/:id/overall_impact', to: 'users#overall_impact'
      post 'users/:id/active_time', to: 'users#add_active_time'
      get '/sort_by_first_name', to: 'users#sort_by_first_name'
      get '/sort_by_last_name', to: 'users#sort_by_last_name'
      get '/sort_by_user_company', to: 'users#sort_by_user_company'
      get '/sort_by_last_sign_in_at', to: 'users#sort_by_last_sign_in_at'

      patch 'users/:id/update_password', to: 'users#update_password'
      post 'forgot_password', to: 'users#forgot_password'
      post 'reset_password', to: 'users#reset_password'
      # For SMS generated with ActiveModel OTP
      # post 'send_otp_code', to: 'users#send_code'
      # post '/verify_code', to: 'users#verify_code'

      # For SMS generated with custom OTP
      post 'send_otp_code', to: 'otps#send_otp'
      post 'verify_otp', to: 'otps#verify_otp'

      get 'programs/:id/program_leaderboard', to: 'programs#current_program_impact'
      get '/last_program', to: 'programs#last_program'
      post '/reward_trackers', to: 'reward_trackers#create'
      get 'reward_trackers/:id', to: 'reward_trackers#show'
      get 'last_workout', to: 'daily_workouts#last_workout'
      resources :programs, only: [ :index, :show, :update, :create, :destroy ] do
        resources :daily_workouts, only: [ :index, :show, :update, :create, :destroy] do
          resources :exercises, only: [ :index, :show, :update, :create, :destroy ]
          resources :exercise_overviews, only: [ :index, :show, :update, :create, :destroy ]
        end
      end

      resources :program_library_items, only: [  :index, :show, :update, :create, :destroy]
        get '/pli_tagged', to: "program_library_items#pli_tagged"
      resources :library_items, only: [ :index, :show, :update, :create, :destroy]
        get '/tagged', to: "library_items#tagged"
      resources :rewards, only: [ :index, :show, :update, :create, :destroy ]
      resources :program_trackers, only: [ :index, :show, :update, :create, :destroy ] do

        resources :daily_workout_trackers, only: [ :index, :show, :update, :create, :destroy ] do
          resources :exercise_trackers, only: [ :index, :show, :update, :create, :destroy ]

        end
      end



      end
    end
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html


# Steps
# 1. Devise
# 2. Pundit
# 3. Set up admin in the user
# 4. generate prgram_trackers and program models

# 5. Make a program only for admin:true

# 6. Rewards--visiible set true to all users, if not only visible to program users

# Look up devise JWT -- Sean

# James -- do daily workouts, and exercises


# CORS how to not let others interact with our API

# Normal user index, show---> nest route for daily_workout_trackers update
# Admin can do everything... will also need a route for library

# resources :programs.admin, only: [ :index,:index, :show, :update, :create]

# 1. generate model
# 2. pundit policy
# 3. make base_controller in api/v1 directory

# endpoints
# route--> controller --> pundit_policy --> view(json) --> test it out in postman

# todo
# cors
# cross origin resource sharing
# stop other site from calling our api
