class CreateShoes < ActiveRecord::Migration[6.0]
  def change
    create_table :shoes do |t|
      t.integer :model_id
      t.integer :store_id
      t.integer :quantity

      t.timestamps
    end
  end
end
