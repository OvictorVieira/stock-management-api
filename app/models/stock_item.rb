class StockItem < ApplicationRecord

  validates_presence_of :quantity, :command, :product_id, :store_id

  ADDED = 0
  REMOVED = 1

  enum command: {
      added: ADDED,
      removed: REMOVED
  }

  belongs_to :store
  belongs_to :product
end
