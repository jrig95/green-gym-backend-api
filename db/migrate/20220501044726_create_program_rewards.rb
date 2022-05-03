class CreateProgramRewards < ActiveRecord::Migration[6.1]
  def change
    create_table :program_rewards do |t|
      t.references :program, null: false, foreign_key: true
      t.references :reward, null: false, foreign_key: true

      t.timestamps
    end
  end
end
