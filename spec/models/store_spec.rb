require 'rails_helper'

RSpec.describe Store, type: :model do
  context 'validations tests' do

    let(:store) { FactoryBot.create(:store) }

    it "is valid with valid attributes" do
      expect(store).to be_valid
    end

    it "is not valid without a name" do
      store.name = nil

      expect(store).to_not be_valid
    end

    it "is not valid without a address" do
      store.address = nil

      expect(store).to_not be_valid
    end
  end

  context 'relationship with stock items' do

    let(:quantity_items) { 15 }

    let!(:store) { create(:store) }
    let!(:product) { create(:product) }
    let(:create_stock_item) {
      -> {
        quantity_items.times { FactoryBot.create(:stock_item, product: product, store: store) }
      }
    }

    it 'returns all product stock items' do
      create_stock_item.call

      products = store.products

      created_product = products.find_by_id(product.id)

      stock_items = created_product.stock_items

      expect(products).to          be_present
      expect(created_product).to   be_present
      expect(stock_items.count).to eql quantity_items
    end

  end
end
