class AddCurrentDayToProgramTrackers < ActiveRecord::Migration[6.1]
  def change
        add_column :program_trackers, :current_day, :integer, default: 0
  end
end
