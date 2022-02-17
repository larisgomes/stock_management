class CreateStockItems < ActiveRecord::Migration[5.0]
  def change
    create_table :stock_items do |t|
      t.references :store, null: false, foreign_key: true
      t.references :product, null: false, foreign_key: true
      t.integer :amount, default: 0

      t.timestamps
    end
  end
end
