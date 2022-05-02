class ChangeProgramIdName < ActiveRecord::Migration[6.1]
  def change
    rename_column :rewards, :program_id_id, :program_id
  end
end
