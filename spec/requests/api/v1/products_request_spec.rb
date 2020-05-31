require 'rails_helper'

RSpec.describe 'Products', type: :request do

  let!(:store) { create(:store, email: 'store@exemple.com') }

  let(:valid_headers) {
    {
      'ACCEPT': 'application/json',
      'X-Store-Email': store.email,
      'X-Store-Token': store.authentication_token
    }
  }

  let(:valid_attributes) {
    {
      name: Faker::Name.name,
      cost_price: rand(10.00...1000.00).round(2).to_s
    }
  }

  describe 'GET /api/v1/products' do

    it 'renders a successful response' do
      total_products = 30
      items_per_page = 4
      page = '3'

      total_products.times do
        Products::ProductService.create(name: valid_attributes[:name],
                                        cost_price: valid_attributes[:cost_price],
                                        store: store)
      end

      get api_v1_products_url, headers: valid_headers,
                               params: {
                                 'per_page': items_per_page,
                                 'page': page
                               }

      response_body = json_parser(response.body)

      expect(response).to                        be_successful
      expect(response_body['current_page']).to   eql page
      expect(response_body['total_products']).to eql total_products
      expect(response_body['products'].count).to eql items_per_page
    end
  end

  describe 'GET /api/v1/products/show/:id' do

    let!(:product) { create(:product) }

    it 'returns a successful response on search a product' do

      get api_v1_product_url(product.id), headers: valid_headers, as: :json

      response_body = json_parser(response.body)

      expect(response).to                 be_successful
      expect(response_body['id']).to      eql(product.id)
      expect(response_body['name']).to    eql(product.name)
      expect(response_body['cost_price']).to eql(product
                                                   .cost_price
                                                   .to_f
                                                   .to_s
                                             )
    end

    it 'returns a not found response on search a product' do

      invalid_product_id = (product.id - 1)

      get api_v1_product_url(invalid_product_id), headers: valid_headers, as: :json

      response_body = json_parser(response.body)

      expect(response).to be_not_found
      expect(response_body['error']['message']).to eql(I18n.t('activerecord.errors.messages.record_not_found',
                                                              model_type: I18n.t('products.label.product'),
                                                              id: invalid_product_id))
    end
  end

  describe 'POST /api/v1/products/create' do

    context 'with valid parameters' do

      it 'creates a new product' do
        post api_v1_products_url, params: { product: valid_attributes },
                                  headers: valid_headers, as: :json

        response_body = json_parser(response.body)

        expect(response_body['id']).to      be_present
        expect(response_body['name']).to    eql(valid_attributes[:name])
        expect(response_body['cost_price']).to eql(valid_attributes[:cost_price])
      end
    end

    context 'with invalid parameters' do

      it 'does not create a new product without address' do

        post api_v1_products_url, params: { product: valid_attributes.except(:cost_price) },
                                  headers: valid_headers, as: :json

        response_body = json_parser(response.body)

        expect(response_body['error']['message']).to eql('A validação falhou: Cost price não pode ficar em branco')
      end
    end
  end

  describe 'PATCH /api/v1/products/update/:id' do

    let!(:product) { create(:product, valid_attributes) }

    context 'with valid parameters' do

      let(:new_attributes) {
        {
          name: Faker::Name.name,
          cost_price: rand(10.00...1000.00).round(2).to_s
        }
      }

      it 'updates the requested product' do

        patch api_v1_product_url(product.id), params: { product: new_attributes },
                                              headers: valid_headers, as: :json

        product.reload

        response_body = json_parser(response.body)

        expect(response_body['id']).to      eql(product.id)
        expect(response_body['name']).to    eql(new_attributes[:name])
        expect(response_body['cost_price']).to eql(new_attributes[:cost_price])
      end
    end
  end

  describe 'DELETE /api/v1/products/destroy/:id' do

    let!(:product) { create(:product, valid_attributes) }

    it 'destroys the requested product' do

      delete api_v1_product_url(product.id), headers: valid_headers, as: :json

      expect(response).to have_http_status(204)
      expect(Product.find_by_id(product.id)).not_to be_present
    end
  end
end
