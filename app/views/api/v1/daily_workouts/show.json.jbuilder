# json.(@daily_workout, :id, :program_id, :day_number,:daily_challenge_title, :daily_challenge_description, :number_of_exercises)

# # json.extract! @daily_workout, :id, :program_id, :day_number, :daily_challenge_title, :daily_challenge_description, :number_of_exercises

# json.exercises @daily_workout.exercises, :id, :exercise_title, :exercise_work_time, :exercise_rest_time, :library_item_id, :exercise_question, :library_item

json.array! @exercises do |exercise|
  json.extract! exercise, :id, :exercise_title, :exercise_title, :exercise_work_time, :exercise_rest_time

  # json.extract! exercise.library_item, :id, :title

  if exercise.library_item.video.attached?
    json.video_url exercise.library_item.video.service_url
  end
end
