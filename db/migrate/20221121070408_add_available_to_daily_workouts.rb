class AddAvailableToDailyWorkouts < ActiveRecord::Migration[6.1]
  def change
    add_column :daily_workouts, :available, :boolean, default: false
  end
end
