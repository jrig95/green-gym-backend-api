class CreatePrograms < ActiveRecord::Migration[6.1]
  def change
    create_table :programs do |t|
      t.string :program_title
      t.text :program_description
      t.integer :number_of_days
      t.string :program_cover_image
      t.timestamps
    end
  end
end
