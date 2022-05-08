class AddUniqueIndexToDwTs < ActiveRecord::Migration[6.1]
  def change
    add_index :daily_workout_trackers, [:program_tracker_id, :daily_workout_id], unique: true, name: 'dwt_id_pt_id_index'
  end
end
