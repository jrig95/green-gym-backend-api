class AddFieldsToPrograms < ActiveRecord::Migration[6.1]
  def change
    add_column :programs, :calories_burned, :integer
    add_column :programs, :trees_planted, :integer
    add_column :programs, :calorie_credits, :integer
  end
end
