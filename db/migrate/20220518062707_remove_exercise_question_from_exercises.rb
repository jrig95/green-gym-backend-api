class RemoveExerciseQuestionFromExercises < ActiveRecord::Migration[6.1]
  def change
    remove_column :exercises, :exercise_question
  end
end
