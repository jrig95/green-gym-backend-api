class ChangeExerciseTrackerColumnNameSubmited < ActiveRecord::Migration[6.1]
  def change
    rename_column :exercise_trackers, :sumbited, :submitted
  end
end
