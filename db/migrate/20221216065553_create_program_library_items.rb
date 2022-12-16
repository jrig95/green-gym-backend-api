class CreateProgramLibraryItems < ActiveRecord::Migration[6.1]
  def change
    create_table :program_library_items do |t|
      t.string :pli_title

      t.timestamps
    end
  end
end
