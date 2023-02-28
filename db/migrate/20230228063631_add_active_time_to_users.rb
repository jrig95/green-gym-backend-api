class AddActiveTimeToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :active_time, :integer, default: 0
  end
end
