class AddColumnCommandToStockItems < ActiveRecord::Migration[6.0]
  def change
    add_column :stock_items, :command, :integer, null: false, default: ''
  end
end
