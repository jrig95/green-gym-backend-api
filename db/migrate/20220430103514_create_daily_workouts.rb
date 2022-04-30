class CreateDailyWorkouts < ActiveRecord::Migration[6.1]
  def change
    create_table :daily_workouts do |t|
      t.references :programs, null: false, foreign_key: true
      t.integer :day_number
      t.string :daily_challenge_title
      t.text :daily_challenge_description
      t.integer :number_of_exercises

      t.timestamps
    end
  end
end
