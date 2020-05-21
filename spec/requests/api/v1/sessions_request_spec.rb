require 'rails_helper'

RSpec.describe 'Sessions', type: :request do

  let(:user) { FactoryBot.create(:user, name: Faker::Name.name, email: "user@gmail.com") }

  describe 'POST /api/v1/users/sign_in' do

    context 'when a user tries to login to the API' do

      it 'returns success' do
        post user_session_path, headers: {
                                  'Content-Type': 'application/json',
                                  'Accept': 'application/json'
                                },
                                params: {
                                  'user': {
                                    'email': user.email,
                                    'password': user.password
                                  }
                                },
                                as: :json

        response_body = json_parser(response.body)

        expect(response).to be_successful
        expect(response.content_type).to eql('application/json; charset=utf-8')

        expect(response_body['name']).to be_present
        expect(response_body['email']).to be_present
        expect(response_body['authentication_token']).to be_present
      end

      it 'returns unauthorized when using invalid email' do
        post user_session_path, headers: {
                                  'Content-Type': 'application/json',
                                  'Accept': 'application/json'
                                },
                                params: {
                                  'user': {
                                    'email': '____@exemple.com',
                                    'password': user.password
                                  }
                                },
                                as: :json

        response_body = json_parser(response.body)

        expect(response).to have_http_status(:unauthorized)
        expect(response.content_type).to eql('application/json; charset=utf-8')

        expect(response_body['error']).to eql('Email ou senha inválida.')
      end

      it 'returns unauthorized when using invalid password' do
        post user_session_path, headers: {
                                  'Content-Type': 'application/json',
                                  'Accept': 'application/json'
                                },
                                params: {
                                  'user': {
                                    'email': '____@exemple.com',
                                    'password': user.password
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
end
