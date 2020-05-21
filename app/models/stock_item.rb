class StockItem < ApplicationRecord

  validates_presence_of :quantity, :product_id, :store_id

  belongs_to :product
  belongs_to :store
end
