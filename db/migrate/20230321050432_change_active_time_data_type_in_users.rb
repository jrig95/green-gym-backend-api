class ChangeActiveTimeDataTypeInUsers < ActiveRecord::Migration[6.1]
  def change
    change_column :users, :active_time, :float
  end
end
