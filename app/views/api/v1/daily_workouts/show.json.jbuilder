json.call(@daily_workout, :id, :program_id, :day_number,:description, :daily_challenge_title, :daily_challenge_description, :number_of_exercises, :date_available, :available)

if @daily_workout.exercise_overviews.exists?
  json.exercise_overviews @exercise_overviews, :id, :daily_workout_id, :overview_exercise_title, :number_of_sets
end

if @daily_workout.exercises.exists?
  json.exercises @exercises, :id, :exercise_title, :exercise_work_time, :exercise_rest_time, :calories_per_exercise, :exercise_question, :library_item_id, :library_item
end
