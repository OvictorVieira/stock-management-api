require 'rails_helper'

RSpec.describe 'Stores', type: :request do

  let(:user) { FactoryBot.create(:user, name: Faker::Name.name, email: 'user@gmail.com') }

  let(:valid_headers) {
    {
      'ACCEPT': 'application/json',
      'X-User-Email': user.email,
      'X-User-Token': user.authentication_token
    }
  }

  let(:valid_attributes) {
    {
      name: Faker::Name.name,
      address: Faker::Address.street_name
    }
  }

  describe 'GET /api/v1/stores/index' do

    it 'renders a successful response' do
      total_stores = 20
      default_items_per_page = 10
      initial_page = 1

      total_stores.times { FactoryBot.create(:store) }

      get api_v1_stores_url, headers: valid_headers, as: :json

      response_body = json_parser(response.body)

      expect(response).to                      be_successful
      expect(response_body['current_page']).to eql initial_page
      expect(response_body['total_stores']).to eql total_stores
      expect(response_body['stores'].count).to eql default_items_per_page
    end
  end

  describe 'GET /api/v1/stores/show' do

    let!(:store) { create(:store) }

    it 'returns a successful response on search a store' do

      get api_v1_store_url(store.id), headers: valid_headers, as: :json

      response_body = json_parser(response.body)

      expect(response).to                 be_successful
      expect(response_body['id']).to      eql(store.id)
      expect(response_body['name']).to    eql(store.name)
      expect(response_body['address']).to eql(store.address)
    end

    it 'returns a not found response on search a store' do

      invalid_store_id = (store.id - 1)

      get api_v1_store_url(invalid_store_id), headers: valid_headers, as: :json

      response_body = json_parser(response.body)

      expect(response).to be_not_found
      expect(response_body['error']['message']).to eql(I18n.t('activerecord.errors.messages.record_not_found', model_type: I18n.t('stores.label.store'), id: invalid_store_id))
    end
  end

  describe 'POST /api/v1/stores/create' do

    context 'with valid parameters' do

      it 'creates a new Store' do
        post api_v1_stores_url, params: { store: valid_attributes }, headers: valid_headers, as: :json

        response_body = json_parser(response.body)

        expect(response_body['id']).to      be_present
        expect(response_body['name']).to    eql(valid_attributes[:name])
        expect(response_body['address']).to eql(valid_attributes[:address])
      end
    end

    context 'with invalid parameters' do

      it 'does not create a new Store without address' do

        post api_v1_stores_url, params: { store: valid_attributes.except(:address) }, headers: valid_headers, as: :json

        response_body = json_parser(response.body)

        expect(response_body['error']['message']).to eql('A validação falhou: Address não pode ficar em branco')
      end
    end
  end

  describe 'PATCH /api/v1/stores/update' do

    let!(:store) { create(:store, valid_attributes) }

    context 'with valid parameters' do

      let(:new_attributes) {
        {
          name: Faker::Name.name,
          address: Faker::Address.street_name
        }
      }

      it 'updates the requested store' do

        patch api_v1_store_url(store.id), params: { store: new_attributes }, headers: valid_headers, as: :json

        store.reload

        response_body = json_parser(response.body)

        expect(response_body['id']).to      eql(store.id)
        expect(response_body['name']).to    eql(new_attributes[:name])
        expect(response_body['address']).to eql(new_attributes[:address])
      end
    end
  end

  describe 'DELETE /api/v1/stores/destroy' do

    let!(:store) { create(:store, valid_attributes) }

    it 'destroys the requested store' do

      delete api_v1_store_url(store.id), headers: valid_headers, as: :json

      expect(response).to have_http_status(204)
      expect(Store.find_by_id(store.id)).not_to be_present
    end
  end
end
