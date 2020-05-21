require 'rails_helper'

RSpec.describe Product, type: :model do
  context 'validations tests' do

    let(:product) { FactoryBot.create(:product) }

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
end
