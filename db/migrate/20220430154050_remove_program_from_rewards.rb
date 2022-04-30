class RemoveProgramFromRewards < ActiveRecord::Migration[6.1]
  def change
    remove_reference :rewards, :program, null: false, foreign_key: true
  end
end
