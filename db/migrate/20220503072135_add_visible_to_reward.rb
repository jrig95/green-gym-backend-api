class AddVisibleToReward < ActiveRecord::Migration[6.1]
  def change
    add_column :rewards, :visible, :boolean
  end
end
