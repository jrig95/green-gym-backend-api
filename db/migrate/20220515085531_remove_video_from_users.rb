class RemoveVideoFromUsers < ActiveRecord::Migration[6.1]
  def change
    remove_column :users, :video, :string
  end
end
