class Store < ApplicationRecord

  validates_presence_of :name, :address

  has_one :stock_item
end
