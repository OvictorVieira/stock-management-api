class Product < ApplicationRecord

  include QuantityCalculable

  validates_presence_of :name, :cost_price

  has_many :stock_items
  has_many :stores, through: :stock_items
end
