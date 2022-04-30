Rails.application.routes.draw do
  devise_for :users
  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :programs, only: [ :index, :show, :update, :create, :destroy ]
    end
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end

# Steps
# 1. Devise
# 2. Pundit
# 3. Set up admin in the user
# 4. generate prgram_trackers and program models

# 5. Make a program only for admin:true

# 6. Rewards--visiible set true to all users, if not only visible to program users

# Look up devise JWT -- Sean

# James -- do daily workouts, and exercises


# CORS how to not let others interact with out API

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
