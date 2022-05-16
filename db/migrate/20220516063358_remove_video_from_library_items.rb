class RemoveVideoFromLibraryItems < ActiveRecord::Migration[6.1]
  def change
    remove_column :library_items, :video, :string
  end
end
