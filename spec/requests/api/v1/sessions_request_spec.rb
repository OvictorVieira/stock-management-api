require 'rails_helper'

RSpec.describe 'Sessions', type: :request do

  let!(:store) { create(:store, email: "store@exemple.com") }

  let(:valid_headers_to_login) {
    {
      'ACCEPT': 'application/json',
      'X-Store-Email': store.email,
      'X-Store-Token': store.authentication_token
    }
  }

  let(:valid_headers_to_create) {
    {
      'Content-Type': 'application/json',
      'Accept': 'application/json'
    }
  }

  let(:valid_create_params) {
    {
      'store': {
        'name': Faker::Name.name,
        'email': 'store2@exemple.com',
        'password': 'PassW0rd',
        'address': 'Faker::Address.street_name'
      }
    }
  }

  let(:valid_params) {
    {
      'store': {
        'email': store.email,
        'password': store.password
      }
    }
  }

  describe 'POST /api/v1/stores/sign_up' do

    context 'when a store tries to sign up on API' do

      it 'returns success' do
        post '/api/v1/stores',  headers: valid_headers_to_create,
                                params: valid_create_params,
                                as: :json

        response_body = json_parser(response.body)

        expect(response).to be_successful

        expect(response_body['name']).to be_present
        expect(response_body['email']).to be_present
        expect(response_body['address']).to be_present
        expect(response_body['authentication_token']).to be_present
      end

      it 'returns unauthorized when using an existing email' do
        valid_create_params[:store][:email] = store.email

        post '/api/v1/stores',  headers: valid_headers_to_create,
                                params: valid_create_params,
                                as: :json

        response_body = json_parser(response.body)

        expect(response).to have_http_status(:unprocessable_entity)
        expect(response_body['errors']).to eql("email"=>["já está em uso"])
      end
    end
  end

  describe 'POST /api/v1/stores/sign_in' do

    context 'when a store tries to login to the API' do

      it 'returns success' do
        post create_store_session_url,  headers: valid_headers_to_create,
                                        params: valid_params,
                                        as: :json

        response_body = json_parser(response.body)

        expect(response).to be_successful

        expect(response_body['name']).to be_present
        expect(response_body['email']).to be_present
        expect(response_body['address']).to be_present
        expect(response_body['authentication_token']).to be_present
      end

      it 'returns unauthorized when using invalid email' do
        post create_store_session_url,  headers: valid_headers_to_create,
                                        params: {
                                          'store': {
                                            'email': '____@exemple.com',
                                            'password': store.password
                                          }
                                        },
                                        as: :json

        response_body = json_parser(response.body)

        expect(response).to have_http_status(:unauthorized)
        expect(response.content_type).to eql('application/json; charset=utf-8')

        expect(response_body['error']).to eql('Email ou senha inválida.')
      end

      it 'returns unauthorized when using invalid password' do
        post create_store_session_url,  headers: valid_headers_to_create,
                                        params: {
                                          'store': {
                                            'email': store.email,
                                            'password': 'invalid_password'
                                          }
                                        },
                                        as: :json

        response_body = json_parser(response.body)

        expect(response).to have_http_status(:unauthorized)
        expect(response.content_type).to eql('application/json; charset=utf-8')

        expect(response_body['error']).to eql('Email ou senha inválida.')
      end
    end
  end

  describe 'DELETE /api/v1/stores/sign_out' do

    context 'when a store tries to login to the API' do

      it 'returns success' do

        delete sign_out_store_session_path, headers: valid_headers_to_login, as: :json

        expect(response).to have_http_status(:ok)
      end

      it 'returns unauthorized when using invalid email' do

        valid_headers_to_login['X-Store-Email'] = 'invalid_email@gmail.com'

        delete sign_out_store_session_path, headers: valid_headers_to_login, as: :json

        response_body = json_parser(response.body)

        expect(response).to have_http_status(:unauthorized)

        expect(response_body['error']).to eql('Para continuar, efetue login ou registre-se.')
      end
    end
  end
end
