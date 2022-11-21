json.extract! @daily_workout_tracker, :id, :dwt_check_in, :dwt_daily_challenge, :percentage_complete, :exercises_completed, :completed, :dwt_day_number, :program_tracker_id, :daily_workout_id, :dwt_available

# json.extract! @daily_workout_tracker.program_tracker, :program_id, :user_id
# json.extract! @daily_workout_tracker.daily_workout, :daily_challenge_title, :day_number, :daily_challenge_description, :number_of_exercises

# json.five_dwts @five_dwts, :dwt_check_in, :dwt_daily_challenge, :completed, :id, :daily_workout
