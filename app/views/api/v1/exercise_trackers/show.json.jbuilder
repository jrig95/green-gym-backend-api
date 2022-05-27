json.extract! @exercise_tracker, :id, :number_of_reps, :daily_workout_tracker_id, :exercise_id, :submitted, :et_exercise_title

json.exercise @exercise_tracker.exercise, :exercise_title, :exercise_work_time, :exercise_rest_time, :calories_per_exercise
