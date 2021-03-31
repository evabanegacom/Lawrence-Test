require 'rails_helper'

RSpec.describe 'Users API', type: :request do
  # rubocop:disable Style/BlockDelimiters
  let(:valid_attributes) {
    { name: 'louiss', email: 'louiss@yahoo.com',
      password: 'password' }
  }
  # rubocop:enable Style/BlockDelimiters
  before { post '/api/v1/users', params: valid_attributes }

  describe 'POST /users' do
    context 'when the request is valid' do
      it 'creates a user' do
        json = JSON.parse(response.body)
        expect(json['user']['name']).to eq('louiss')
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end
    context 'when the request is invalid' do
      before { post '/api/v1/users', params: { name: 'louisss' } }

      it 'returns creation status as false' do
        json = JSON.parse(response.body)
        expect(json['error']).to match('Invalid name or password')
      end

      it 'returns a validation failure message' do
        json = JSON.parse(response.body)
        expect(json['error'])
          .to match('Invalid name or password')
      end
    end
  end

  describe 'POST /login' do
    context 'when user logs in with valid parameters' do
      let(:login_attributes) { { email: 'louiss@yahoo.com', password: 'password' } }
      before { post '/api/v1/login', params: login_attributes }

      it 'logs in a user' do
        json = JSON.parse(response.body)
        expect(json['user']['email']).to eq('louiss@yahoo.com')
        expect(json['user']['name']).to eq('louiss')
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end
  end

  context 'when user logs in with invalid parameters' do
    let(:login_attributes) { { name: 'louiss', password: 'pass' } }
    before { post '/api/v1/login', params: login_attributes }

    it 'returns login status as not_logged_in' do
      json = JSON.parse(response.body)
      expect(json['loggedIn']).to match(false)
    end

    it 'returns an error message' do
      json = JSON.parse(response.body)
      expect(json['error']).to match('Invalid name or password')
    end
  end

  describe 'GET /auto_login' do
    let(:login_attributes) { { name: 'louiss', password: 'password' } }
    context 'when the current user is not authorized' do
      before { get '/api/v1/auto_login' }

      it 'validates an un-authorized user' do
        json = JSON.parse(response.body)
        expect(json['message']).to eq('Please log in')
      end

      it 'returns status code 401' do
        expect(response).to have_http_status(401)
      end
    end

    context 'when the current user is authorized' do
      after { get '/api/v1/auto_login' }

      it 'returns the name of current user' do
        json = JSON.parse(response.body)
        expect(json['user']['name']).to match('louiss')
      end
    end
  end
end
