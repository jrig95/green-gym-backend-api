class AddExerciseQuestionToExercises < ActiveRecord::Migration[6.1]
  def change
    add_column :exercises, :exercise_question, :boolean
  end
end
