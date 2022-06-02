json.extract! @user, :id, :email, :created_at, :updated_at, :sign_in_count, :current_sign_in_at, :last_sign_in_at, :current_sign_in_ip, :last_sign_in_ip, :admin, :first_name, :last_name, :user_company, :user_total_calories, :user_points, :user_gender, :user_fitness_level, :user_passions, :age, :phone_number

if @user.photo.attached?
  json.photo_url @user.photo.service_url
end

if @user.programs
  json.programs @user.programs, :id, :program_title, :program_title, :program_description, :number_of_days
end

# if @user.program_trackers
  json.program_trackers @user.program_trackers, :id, :daily_workout_trackers, :exercise_trackers
  # json.daily_workout_trackers @daily_workout_trackers, :id, :daily_workout_id, :dwt_check_in, :dwt_daily_challenge, :exercises_completed, :completed, :dwt_day_number, :percentage_complete, :exercise_trackers
# end






# json.exercise_trackers @exercise_trackers, :id, :number_of_reps, :submitted
