class AddDefaultToDwtCheckIn < ActiveRecord::Migration[6.1]
  def change
    change_column :daily_workout_trackers, :dwt_check_in, :boolean, :default => false
  end
end
