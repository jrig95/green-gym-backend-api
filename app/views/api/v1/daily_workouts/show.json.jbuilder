json.(@daily_workout, :id, :program_id, :day_number,:daily_challenge_title, :daily_challenge_description, :number_of_exercises)

# json.extract! @daily_workout, :id, :program_id, :day_number, :daily_challenge_title, :daily_challenge_description, :number_of_exercises

json.exercises @daily_workout.exercises, :id, :exercise_title, :exercise_work_time, :exercise_rest_time, :library_item_id, :exercise_question, :library_item

