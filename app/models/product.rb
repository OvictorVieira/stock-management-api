class Product < ApplicationRecord

  validates_presence_of :name, :cost_price

  has_one :stock_item
end
