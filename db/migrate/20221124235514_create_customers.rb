class CreateCustomers < ActiveRecord::Migration[7.0]
  def change
    create_table :customers do |t|
      t.string :first_name
      t.string :last_name
      t.string :building_apt_number
      t.string :street
      t.string :city
      t.string :province
      t.string :zip_code
      t.string :country
      t.string :email
      t.string :password

      t.timestamps
    end
  end
end
