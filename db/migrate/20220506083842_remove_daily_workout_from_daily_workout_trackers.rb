class RemoveDailyWorkoutFromDailyWorkoutTrackers < ActiveRecord::Migration[6.1]
  def change
    remove_reference :daily_workout_trackers, :daily_workout
  end
end
