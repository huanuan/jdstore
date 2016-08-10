class AddMoreDetailToProduct < ActiveRecord::Migration[5.0]
  def change
    add_column :products, :contact_email, :string
  end
end
