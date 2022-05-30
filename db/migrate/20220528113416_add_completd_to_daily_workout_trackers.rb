class AddCompletdToDailyWorkoutTrackers < ActiveRecord::Migration[6.1]
  def change
    add_column :daily_workout_trackers, :completed, :boolean, default: false
  end
end
