class AddSubmitToExerciseTrackers < ActiveRecord::Migration[6.1]
  def change
    add_column :exercise_trackers, :submitted, :boolean, :default => false
  end
end
