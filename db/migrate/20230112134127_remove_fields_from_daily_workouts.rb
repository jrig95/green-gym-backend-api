class RemoveFieldsFromDailyWorkouts < ActiveRecord::Migration[6.1]
  def change
    remove_column :daily_workouts, :date_available, :datetime
    remove_column :daily_workouts, :available, :boolean
  end
end
