class StockItem < ApplicationRecord

  validates_presence_of :quantity, :command, :product_id, :store_id

  enum command: {
      added: 0,
      removed: 1
  }

  belongs_to :store
  belongs_to :product
end
