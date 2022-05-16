class AddFieldsToUser < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
    add_column :users, :user_company, :string
    add_column :users, :user_total_calories, :integer
    add_column :users, :user_points, :integer
    add_column :users, :user_passions, :text
    add_column :users, :user_gender, :string
    add_column :users, :user_fitness_level, :string
  end
end
