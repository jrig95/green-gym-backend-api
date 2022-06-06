json.array! @daily_workout_trackers do |daily_workout_tracker|
  json.extract! daily_workout_tracker, :id, :program_tracker_id, :daily_workout_id, :dwt_check_in, :dwt_daily_challenge, :percentage_complete, :completed, :dwt_day_number
end
