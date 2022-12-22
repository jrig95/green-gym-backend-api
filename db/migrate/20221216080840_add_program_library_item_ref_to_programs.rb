class AddProgramLibraryItemRefToPrograms < ActiveRecord::Migration[6.1]
  def change
    add_reference :programs, :program_library_item, foreign_key: true
  end
end
