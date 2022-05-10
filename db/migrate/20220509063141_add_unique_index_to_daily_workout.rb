class AddUniqueIndexToDailyWorkout < ActiveRecord::Migration[6.1]
  def change
    add_index :daily_workouts, [:program_id, :day_number], unique: true, name: 'dw_day_num_and_program_id_index'
  end
end
