class AddDwtAvailableToDwTs < ActiveRecord::Migration[6.1]
  def change
    add_column :daily_workout_trackers, :dwt_available, :boolean, default: false
  end
end
