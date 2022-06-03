json.extract! @program_tracker, :id, :program_id, :user_id, :current_day

json.extract! @program_tracker.program, :program_title, :program_description
json.extract! @program_tracker.user, :email, :admin

json.daily_workout_trackers @program_tracker.daily_workout_trackers, :id, :daily_workout_id, :dwt_check_in, :dwt_daily_challenge, :exercises_completed, :completed, :dwt_day_number, :percentage_complete , :exercise_trackers

# json.exercise_trackers @exercise_trackers, :id, :number_of_reps, :submitted
