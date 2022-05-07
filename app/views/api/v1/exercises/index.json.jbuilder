json.array! @exercises do |exercise|
  json.extract! exercise, :id, :exercise_title, :exercise_question, :exercise_work_time, :exercise_rest_time, :calories_per_exercise, :daily_workout_id, :library_item_id
end

# , :exercise_question, :exercise_work_time, :exercise_rest_time, :calories_per_exercise
