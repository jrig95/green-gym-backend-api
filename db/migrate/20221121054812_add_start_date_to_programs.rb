class AddStartDateToPrograms < ActiveRecord::Migration[6.1]
  def change
    add_column :programs, :start_date, :datetime
  end
end
