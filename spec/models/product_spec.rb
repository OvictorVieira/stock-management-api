require 'rails_helper'

RSpec.describe Product, type: :model do
  context 'validations tests' do

    let!(:product) { create(:product) }

    it "is valid with valid attributes" do
      expect(product).to be_valid
    end

    it "is not valid without a name" do
      product.name = nil

      expect(product).to_not be_valid
    end

    it "is not valid without a cost price" do
      product.cost_price = nil

      expect(product).to_not be_valid
    end
  end

  context 'relationship with stock items' do

    let(:quantity_items) { 10 }

    let!(:product) { create(:product) }
    let!(:store) { create(:store, email: 'user@exemple.com') }
    let(:create_stock_item) {
      -> {
        quantity_items.times { FactoryBot.create(:stock_item,
                                                 product: product,
                                                 store: store,
                                                 command: StockItem::ADDED) }
      }
    }

    it 'returns all product stock items' do
      create_stock_item.call

      stock_items = product.stock_items

      expect(stock_items.count).to eql quantity_items
    end

  end
end
