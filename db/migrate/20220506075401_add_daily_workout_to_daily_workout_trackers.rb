class AddDailyWorkoutToDailyWorkoutTrackers < ActiveRecord::Migration[6.1]
  def change
    add_reference :daily_workout_trackers, :daily_workout
  end
end
