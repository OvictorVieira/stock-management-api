class ChangeDefaultStockItemQuantity < ActiveRecord::Migration[6.0]
  def change
    change_column_default :stock_items, :quantity, 0
  end
end
