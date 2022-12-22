class AddProgramLibraryItemRefToDailyWorkouts < ActiveRecord::Migration[6.1]
  def change
    add_reference :daily_workouts, :program_library_item, foreign_key: true
  end
end
