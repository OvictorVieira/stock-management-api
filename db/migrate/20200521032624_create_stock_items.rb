class CreateStockItems < ActiveRecord::Migration[6.0]
  def change
    create_table :stock_items do |t|

      t.integer :quantity, null: false

      t.references :store, :product, foreign_key: true, null: false

      t.timestamps
    end
  end
end
