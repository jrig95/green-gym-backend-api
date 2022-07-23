class CreateOtps < ActiveRecord::Migration[6.1]
  def change
    create_table :otps do |t|
      t.string :phone_number
      t.string :code
      t.boolean :used, default: false
      t.datetime :used_at
      t.boolean :expired, default: false
      t.datetime :expired_at
      # t.datetime :created_at, precision: 6, null: false
      # t.datetime :updated_at, precision: 6, null: false

      t.timestamps
    end
  end
end
