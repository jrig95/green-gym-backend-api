class RemoveStartDateFromPrograms < ActiveRecord::Migration[6.1]
  def change
    remove_column :programs, :start_date, :boolean
  end
end
