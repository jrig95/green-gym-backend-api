class AddProgramIdtoRewards < ActiveRecord::Migration[6.1]
  def change
    add_reference :rewards, :program_id
  end
end
