class AddExerciseNameToExerciseTracker < ActiveRecord::Migration[6.1]
  def change
    add_column :exercise_trackers, :et_exercise_title, :string
  end
end
