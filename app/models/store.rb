class Store < ApplicationRecord

  validates_presence_of :name, :address

  has_and_belongs_to_many :stock_item, through: :products
end
