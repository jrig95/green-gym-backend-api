class AddDescriptionToDailyWorkouts < ActiveRecord::Migration[6.1]
  def change
    add_column :daily_workouts, :description, :text
  end
end
