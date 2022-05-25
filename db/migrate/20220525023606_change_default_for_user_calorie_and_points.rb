class ChangeDefaultForUserCalorieAndPoints < ActiveRecord::Migration[6.1]
  def change
    change_column :users, :user_points, :integer, default: 0
    change_column :users, :user_total_calories, :integer, default: 0
  end
end
