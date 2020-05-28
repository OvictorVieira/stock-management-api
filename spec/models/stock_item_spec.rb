require 'rails_helper'

RSpec.describe StockItem, type: :model do

  context 'validations tests' do

    let(:product) { FactoryBot.create(:product) }
    let(:store) { FactoryBot.create(:store) }
    let(:stock_item) { FactoryBot.create(:stock_item, product: product, store: store) }

    it "is valid with valid attributes" do
      expect(stock_item).to be_valid
    end

    it "is not valid without a quantity" do
      stock_item.quantity = nil

      expect(stock_item).to_not be_valid
    end

    it "is not valid without a product_id" do
      stock_item.product_id = nil

      expect(stock_item).to_not be_valid
    end

    it "is not valid without a store_id" do
      stock_item.store_id = nil

      expect(stock_item).to_not be_valid
    end

    it "is not valid without a command" do
      stock_item.command = nil

      expect(stock_item).to_not be_valid
    end
  end
end
