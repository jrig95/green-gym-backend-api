json.array! @daily_workout_trackers do |daily_workout_tracker|
  json.extract! daily_workout_tracker, :id, :program_tracker_id, :daily_workout_id
end
