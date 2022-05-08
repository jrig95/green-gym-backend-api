class DropProgramRewards < ActiveRecord::Migration[6.1]
  def change
    drop_table :program_rewards
  end
end
