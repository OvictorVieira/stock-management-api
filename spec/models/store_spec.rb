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
end
