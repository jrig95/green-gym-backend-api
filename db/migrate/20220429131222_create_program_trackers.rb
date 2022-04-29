class CreateProgramTrackers < ActiveRecord::Migration[6.1]
  def change
    create_table :program_trackers do |t|
      t.references :program, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
