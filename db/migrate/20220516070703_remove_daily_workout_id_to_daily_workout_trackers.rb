class RemoveDailyWorkoutIdToDailyWorkoutTrackers < ActiveRecord::Migration[6.1]
  def change
    remove_column :daily_workout_trackers, :daily_workouts_id
  end
end
