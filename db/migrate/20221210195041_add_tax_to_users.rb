class AddTaxToUsers < ActiveRecord::Migration[7.0]
  def change
    add_reference :users, :tax, null: false, foreign_key: true
  end
end
