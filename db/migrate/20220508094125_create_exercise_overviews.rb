class CreateExerciseOverviews < ActiveRecord::Migration[6.1]
  def change
    create_table :exercise_overviews do |t|
      t.references :daily_workout, null: false, foreign_key: true
      t.string :overview_exercise_title
      t.integer :number_of_sets

      t.timestamps
    end
  end
end
