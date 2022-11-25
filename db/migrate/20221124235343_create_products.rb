class CreateProducts < ActiveRecord::Migration[7.0]
  def change
    create_table :products do |t|
      t.string :name
      t.string :screen
      t.string :screen_size
      t.string :cpu
      t.string :gpu
      t.string :ram
      t.string :storage
      t.string :operating_system
      t.string :operating_system_version
      t.decimal :price
      t.references :category, null: false, foreign_key: true

      t.timestamps
    end
  end
end
