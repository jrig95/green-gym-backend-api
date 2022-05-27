class AddDayNumberToDailyWorkoutTracker < ActiveRecord::Migration[6.1]
  def change
    add_column :daily_workout_trackers, :dwt_day_number, :integer
  end
end
