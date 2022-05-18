class RemoveRewardImageFromReward < ActiveRecord::Migration[6.1]
  def change
    remove_column :rewards, :reward_image, :string
  end
end
