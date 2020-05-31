class ChangeNameToNotUniqueOnStores < ActiveRecord::Migration[6.0]
  def change
    remove_index :stores, :name
    add_index :stores, :name, unique: false
  end
end
