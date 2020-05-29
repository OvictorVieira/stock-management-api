require 'rails_helper'

RSpec.describe 'StockItems', type: :request do
  let!(:product) { create(:product) }
  let!(:store) { create(:store, email: 'store@gmail.com') }


  let(:valid_headers) {
    {
      'ACCEPT': 'application/json',
      'X-Store-Email': store.email,
      'X-Store-Token': store.authentication_token
    }
  }

  let(:valid_attributes) {
    {
      quantity: 0,
      product_id: product.id
    }
  }

  describe 'POST /api/v1/stock_items/add_item' do

    context 'with valid parameters' do

      it 'adds ten items to the product' do

        valid_attributes[:quantity] = 10

        post api_v1_stock_items_add_item_url, params: {
                                               stock_item: valid_attributes
                                             },
                                             headers: valid_headers, as: :json

        expect(response).to have_http_status :created
      end
    end
  end
end
