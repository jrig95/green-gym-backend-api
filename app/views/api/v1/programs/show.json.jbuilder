json.(@program, :id, :program_title, :program_description, :price)

if @program.photo.attached?
  json.photo_url @program.photo.service_url
end

json.daily_workouts @program.daily_workouts, :id, :program_id, :day_number, :daily_challenge_title, :daily_challenge_description, :number_of_exercises, :exercise_overviews, :exercises
