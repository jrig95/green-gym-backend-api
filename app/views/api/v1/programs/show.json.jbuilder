json.(@program, :id, :program_title, :program_description, :price, :start_date)

if @program.photo.attached?
  json.photo_url @program.photo.service_url
end

if @program.daily_workouts.exists?
  json.daily_workouts @daily_workouts, :id, :program_id, :description, :day_number, :daily_challenge_title, :daily_challenge_description, :number_of_exercises, :exercise_overviews, :exercises
end
