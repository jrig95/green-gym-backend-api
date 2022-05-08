json.extract! @exercise_tracker, :id, :number_of_reps, :daily_workout_tracker_id, :exercise_id

json.extract! @exercise_tracker.exercise, :exercise_title, :exercise_work_time, :exercise_rest_time, :calories_per_exercise
