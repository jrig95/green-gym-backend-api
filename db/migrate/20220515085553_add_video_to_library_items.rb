class AddVideoToLibraryItems < ActiveRecord::Migration[6.1]
  def change
    add_column :library_items, :video, :string
  end
end
