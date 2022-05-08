json.array! @exercise_overviews do |exercise_overview|
  json.extract! exercise_overview, :id, :overview_exercise_title, :number_of_sets, :daily_workout_id
end
