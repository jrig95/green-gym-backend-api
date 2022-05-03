class CreateExercises < ActiveRecord::Migration[6.1]
  def change
    create_table :exercises do |t|
      t.string :exercise_title
      t.string :exercise_question
      t.string :exercise_work_time
      t.string :exercise_rest_time
      t.integer :calories_per_exercise
      t.references :daily_workout, null: false, foreign_key: true
      t.references :library_item, null: false, foreign_key: true

      t.timestamps
    end
  end
end
