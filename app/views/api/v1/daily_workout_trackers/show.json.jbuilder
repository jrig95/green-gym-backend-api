json.extract! @daily_workout_tracker, :dwt_day_number, :dwt_check_in, :dwt_daily_challenge

json.extract! @daily_workout_tracker.program_tracker, :program_id, :user_id
# json.extract! @program_tracker.user, :email, :admin
