class RemoveProgramCoverImageFromProgram < ActiveRecord::Migration[6.1]
  def change
    remove_column :programs, :program_cover_image, :string
  end
end
