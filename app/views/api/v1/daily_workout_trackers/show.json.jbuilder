json.extract! @daily_workout_tracker, :id, :dwt_check_in, :dwt_daily_challenge, :program_tracker_id, :daily_workout_id

json.extract! @daily_workout_tracker.program_tracker, :program_id, :user_id
json.extract! @daily_workout_tracker.daily_workout, :daily_challenge_title, :day_number, :daily_challenge_description, :number_of_exercises

# json.extract! @five_day_array.daily_workout_tracker, :id, :daily_workout_tracker_id, :program_tracker_id, :daily_workout_id, :dwt_check_in, :dwt_daily_challenge
# hash = { author: { name: "David" } }
# json.post do
#   json.title "Merge HOWTO"
#   json.merge! hash
# end

json.five_dwts @five_dwts,  :dwt_check_in, :dwt_daily_challenge, :id, :daily_workout

# json.five_dwts do
#   json.day_number @daily_workout_tracker.daily_workout
# end

# hash = { daily_workout: { day_number: @daily_workout_tracker.daily_workout.day_number} }
# json.five_dwts @five_dwts do
#   json.merge! hash
# end

# json.array! @five_dwts do |dwt|
#   json.extract! dwt, :dwt_check_in, :dwt_daily_challenge, :id
# end



# json.five_dwts do
#   json.program_tracker_id @five_dwts.program_tracker_id
#   json.daily_workout_id @five_dwts.daily_workout_id
# end
