class Product < ApplicationRecord

  validates_presence_of :name, :cost_price

  has_and_belongs_to_many :stock_item, through: :stores
end
