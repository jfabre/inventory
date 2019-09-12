class AddUniqueIndexOnSales < ActiveRecord::Migration[6.0]
  def change
    add_index :sales, [:store_id, :model_id, :created_at], unique: true
  end
end
