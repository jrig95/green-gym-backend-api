class CreateRewards < ActiveRecord::Migration[6.1]
  def change
    create_table :rewards do |t|
      t.boolean :reward_visible
      t.string :reward_name
      t.string :reward_image
      t.integer :reward_points
      t.references :program, null: false, foreign_key: true

      t.timestamps
    end
  end
end
