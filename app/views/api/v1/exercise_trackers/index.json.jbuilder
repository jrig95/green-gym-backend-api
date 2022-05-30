json.array! @exercise_trackers do |exercise_tracker|
  json.extract! exercise_tracker, :id, :exercise_id, :daily_workout_tracker_id, :number_of_reps, :submitted
end
