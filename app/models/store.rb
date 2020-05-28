class Store < ApplicationRecord

  validates_presence_of :name, :address

  has_many :stock_items
  has_many :products, through: :stock_items
end
