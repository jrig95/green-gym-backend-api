class AddVideoToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :video, :string
  end
end
