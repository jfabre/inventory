class IndexesAndUniqueness < ActiveRecord::Migration[6.0]
  def change
    add_index :shoes, [:store_id, :model_id], unique: true
    add_index :stores, :name, unique: true
    add_index :models, :name, unique: true

    change_column_default :shoes, :quantity, from: nil, to: 0

    change_column_null :shoes, :quantity, false
    change_column_null :shoes, :model_id, false
    change_column_null :shoes, :store_id, false

    change_column_null :stores, :name, false
    change_column_null :models, :name, false
  end
end
