class CreateRewardTrackers < ActiveRecord::Migration[6.1]
  def change
    create_table :reward_trackers do |t|
      t.references :reward, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
