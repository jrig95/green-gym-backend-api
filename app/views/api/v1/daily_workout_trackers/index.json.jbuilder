json.array! @daily_workout_trackers do |daily_workout_tracker|
  json.extract! daily_workout_tracker, :id, :dwt_day_number
end
