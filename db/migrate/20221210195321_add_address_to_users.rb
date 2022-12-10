class AddAddressToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :street, :string
    add_column :users, :city, :string
    add_column :users, :province, :string
    add_column :users, :zipcode, :string
  end
end
