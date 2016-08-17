class RenameShipping < ActiveRecord::Migration[5.0]
  def change
    rename_column :orders, :shopping_name, :shipping_name
    rename_column :orders, :shopping_address, :shipping_address
  end
end
