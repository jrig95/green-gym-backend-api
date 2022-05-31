class AddWorkoutCompletToDailyWorkoutTrackers < ActiveRecord::Migration[6.1]
  def change
    add_column :daily_workout_trackers, :exercises_completed, :boolean, default: false
  end
end
