json.array! @exercises do |exercise|
  json.extract! exercise, :id, :exercise_title, :exercise_question, :exercise_work_time, :exercise_rest_time, :calories_per_exercise
end

# , :exercise_question, :exercise_work_time, :exercise_rest_time, :calories_per_exercise
