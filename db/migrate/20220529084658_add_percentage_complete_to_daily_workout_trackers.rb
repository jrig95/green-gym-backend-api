class AddPercentageCompleteToDailyWorkoutTrackers < ActiveRecord::Migration[6.1]
  def change
    add_column :daily_workout_trackers, :percentage_complete, :float, default: 0.0
  end
end
