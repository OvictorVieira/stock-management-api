class CreateProducts < ActiveRecord::Migration[6.0]
  def change
    create_table :products do |t|
      t.string :name, null: false
      t.decimal :cost_price, null: false, precision: 8, scale: 2

      t.timestamps
    end

    add_index :products, :name
  end
end
