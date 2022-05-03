class ChangeExerciseQuestionToBoolean < ActiveRecord::Migration[6.1]
  def change
    change_table :exercises do |table|
    table.change :exercise_question, :boolean
  end
  end
end
