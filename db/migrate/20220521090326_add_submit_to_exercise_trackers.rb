class AddSubmitToExerciseTrackers < ActiveRecord::Migration[6.1]
  def change
    add_column :exercise_trackers, :sumbited, :boolean, :default => false
  end
end
