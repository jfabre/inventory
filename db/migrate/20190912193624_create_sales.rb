class CreateSales < ActiveRecord::Migration[6.0]
  def change
    create_table :sales do |t|
      t.integer :model_id, null: false
      t.integer :store_id, null: false
      t.integer :new_inventory, null: false, default: 0
      t.integer :quantity_sold, null: false

      t.timestamps
    end
  end
end
