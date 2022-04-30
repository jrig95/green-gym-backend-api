class RemoveRewardVisibleFromRewards < ActiveRecord::Migration[6.1]
  def change
    remove_column :rewards, :reward_visible, :boolean
  end
end
