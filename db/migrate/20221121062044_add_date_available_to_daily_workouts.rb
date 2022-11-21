class AddDateAvailableToDailyWorkouts < ActiveRecord::Migration[6.1]
  def change
    add_column :daily_workouts, :date_available, :datetime
  end
end
