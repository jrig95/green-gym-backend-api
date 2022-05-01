class ChangeProgramsIdToProgramId < ActiveRecord::Migration[6.1]
  def change
    rename_column :daily_workouts, :programs_id, :program_id
  end
end
