class ChangeActiveTimeDefaultToZeroInUsers < ActiveRecord::Migration[6.1]
  def change
     change_column_default :users, :active_time, 0
  end
end
