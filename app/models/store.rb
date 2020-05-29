class Store < ApplicationRecord
  acts_as_token_authenticatable

  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable

  validates_presence_of :name, :address, :name, :email, :encrypted_password

  has_many :stock_items
  has_many :products, through: :stock_items
end
