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

    context 'with invalid parameters' do

      it 'when you submit the invalid product_id' do

        valid_attributes[:product_id] = -1

        post api_v1_stock_items_add_item_url, params: {
                                                stock_item: valid_attributes
                                              },
                                              headers: valid_headers, as: :json

        response_body = json_parser(response.body)

        expect(response).to have_http_status :unprocessable_entity
        expect(response_body['error']['message']).to eql I18n.t('activerecord.errors.messages.record_invalid',
                                                                errors: I18n.t('stock_items.errors.invalid_product'))
      end

      it 'when you submit the invalid quantity' do

        valid_attributes[:quantity] = -3

        post api_v1_stock_items_add_item_url, params: {
                                                stock_item: valid_attributes
                                              },
                                              headers: valid_headers, as: :json

        response_body = json_parser(response.body)

        expect(response).to have_http_status :unprocessable_entity
        expect(response_body['error']['message']).to eql I18n.t('activerecord.errors.messages.record_invalid',
                                                                errors: I18n.t('stock_items.errors.invalid_quantity'))
      end
    end
  end

  describe 'POST /api/v1/stock_items/remove_item' do

    context 'product started with 15 items and had 2 sales so far (13 items in stock)' do

      started_quantity = 15
      sold_amount = 2

      before do
        start_with_15_and_sells_2_items = -> {
          started_quantity.times do
            FactoryBot.create(:stock_item,
                              product: product,
                              store: store,
                              quantity: 1,
                              command: StockItem::ADDED)
          end

          sold_amount.times do
            FactoryBot.create(:stock_item,
                              product: product,
                              store: store,
                              quantity: 1,
                              command: StockItem::REMOVED)
          end
        }

        start_with_15_and_sells_2_items.call
      end

      it 'have 4 more sales' do

        valid_attributes[:quantity] = 2

        post api_v1_stock_items_remove_item_url,  params: {
                                                    stock_item: valid_attributes
                                                  },
                                                  headers: valid_headers, as: :json

        expect(response).to have_http_status :created
        expect(product.calculate_quantity).to eql(started_quantity - sold_amount - valid_attributes[:quantity])
      end

      it 'when all the quantity is sold' do

        valid_attributes[:quantity] = 13

        post api_v1_stock_items_remove_item_url,  params: {
                                                    stock_item: valid_attributes
                                                  },
                                                  headers: valid_headers, as: :json

        expect(response).to have_http_status :created
        expect(product.calculate_quantity).to eql(0)
      end

      it 'tries to sell more than it has in stock' do

        valid_attributes[:quantity] = 20

        post api_v1_stock_items_remove_item_url,  params: {
                                                    stock_item: valid_attributes
                                                  },
                                                  headers: valid_headers, as: :json

        response_body = json_parser(response.body)

        expect(response).to have_http_status :unprocessable_entity
        expect(response_body['error']['message']).to eql I18n.t('activerecord.errors.messages.record_invalid',
                                                                errors: I18n.t('stock_items.errors.insufficient_quantity'))
      end
    end

    context 'with invalid parameters' do

      it 'when the product does not have enough quantity' do

        valid_attributes[:quantity] = 1

        post api_v1_stock_items_remove_item_url,  params: {
                                                    stock_item: valid_attributes
                                                  },
                                                  headers: valid_headers, as: :json

        response_body = json_parser(response.body)

        expect(response).to have_http_status :unprocessable_entity
        expect(response_body['error']['message']).to eql I18n.t('activerecord.errors.messages.record_invalid',
                                                                errors: I18n.t('stock_items.errors.insufficient_quantity'))
      end

      it 'when you submit the invalid product_id' do

        FactoryBot.create(:stock_item, product: product, store: store, quantity: 5, command: StockItem::ADDED)

        valid_attributes[:product_id] = -1

        post api_v1_stock_items_remove_item_url,  params: {
                                                    stock_item: valid_attributes
                                                  },
                                                  headers: valid_headers, as: :json

        response_body = json_parser(response.body)

        expect(response).to have_http_status :unprocessable_entity
        expect(response_body['error']['message']).to eql I18n.t('activerecord.errors.messages.record_invalid',
                                                                errors: I18n.t('stock_items.errors.invalid_product'))
      end

      it 'when you submit the invalid quantity' do

        FactoryBot.create(:stock_item, product: product, store: store, quantity: 5, command: StockItem::ADDED)

        valid_attributes[:quantity] = -5

        post api_v1_stock_items_remove_item_url,  params: {
                                                    stock_item: valid_attributes
                                                  },
                                                  headers: valid_headers, as: :json

        response_body = json_parser(response.body)

        expect(response).to have_http_status :unprocessable_entity
        expect(response_body['error']['message']).to eql I18n.t('activerecord.errors.messages.record_invalid',
                                                                errors: I18n.t('stock_items.errors.invalid_quantity'))
      end
    end
  end
end
