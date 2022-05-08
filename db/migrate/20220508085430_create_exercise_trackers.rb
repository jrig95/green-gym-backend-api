class CreateExerciseTrackers < ActiveRecord::Migration[6.1]
  def change
    create_table :exercise_trackers do |t|
      t.integer :number_of_reps
      t.references :daily_workout_tracker, null: false, foreign_key: true
      t.references :exercise, null: false, foreign_key: true

      t.timestamps
    end
  end
end
