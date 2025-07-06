require 'rails_helper'

RSpec.describe 'Users API', type: :request do
  describe 'POST /users' do
    let(:valid_attributes) { { name: 'John Doe', email: 'johndoe123@gmail.com' } }

    context 'when the request is valid' do
      before { post '/users', params: { user: valid_attributes } }

      it 'creates a new user' do
        expect {
          post '/users', params: { user: valid_attributes }
        }.to change(User, :count).by(1)
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end

      it 'returns the created user' do
        expect(json['name']).to eq('John Doe')
        expect(json['email']).to eq('johndoe123@gmail.com')
      end

      it 'saves the user with the correct attributes' do
        user = User.last
        expect(user.name).to eq('John Doe')
        expect(user.email).to eq('johndoe123@gmail.com')
      end

    end

    context 'when the request is invalid' do
      before { post '/users', params: { user: { name: '', email: '' } } }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a validation failure message' do
        expect(json['name']).to include("can't be blank")
        expect(json['email']).to include("can't be blank")
      end
    end

  end

  describe 'GET /users' do
    let!(:users) { create_list(:user, 10) } # creating 10 users using Factory Bot

    before { get '/users' }

    it 'returns users' do
      expect(response).to have_http_status(200)
      expect(json).not_to be_empty
      expect(json.size).to eq(10)
    end

    it 'returns users with the correct structure' do
      # Assuming each user has 'name' and 'email'
      json.each do |user|
        expect(user).to include('name', 'email')
      end
    end
  end

  describe 'GET /users/:id' do
    let!(:user) { create(:user) }

    before { get "/users/#{user.id}" }

    it 'returns the user' do
      expect(response).to have_http_status(200)
      expect(json).not_to be_empty
      expect(json['id']).to eq(user.id)
    end

    it 'should have the correct structure' do
      expect(json).to include('name', 'email')
    end

  end

  describe 'PUT /users/:id' do
    let!(:user) { create(:user) }

    context 'when the request is valid' do
      before { put "/users/#{user.id}", params: { user: { name: 'Jane Doe', email: 'janedoe123@gmail.com' } } }

      it 'updates the user' do
        expect(response).to have_http_status(200)
        expect(json['name']).to eq('Jane Doe')
        expect(json['email']).to eq('janedoe123@gmail.com') 
      end
    end

    context 'when the request is invalid' do
      before { put "/users/#{user.id}", params: { user: { name: '', email: '' } } }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a validation failure message' do
        expect(json['name']).to include("can't be blank")
        expect(json['email']).to include("can't be blank")
      end
    end

  end

  describe 'DELETE /users/:id' do
    let!(:user) { create(:user) }

    before { delete "/users/#{user.id}" }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end

  def json
    JSON.parse(response.body)
  end

end