class AddUniqueIndexToProgramTracker < ActiveRecord::Migration[6.1]
  def change
        add_index :program_trackers, [:program_id, :user_id], unique: true, name: 'unique_user_and_program_combination'
  end
end
