require 'rails_helper'

RSpec.describe "Blogs", type: :request do
  describe "GET /index" do
    let(:blog) { create(:blog) }

    before do
      blog
      get '/blogs'
    end

    it 'returns http success' do
      expect(response).to have_http_status(:success)
    end

    it 'returns a list of blogs' do
      expect(response.body).to eq(Blog.all.to_json)
    end
  end

  describe "POST /create" do
    let(:user) { create(:user) }

    context "when the blog is valid" do
      before do
        post '/blogs', params: { title: "Test Title", content: "Test Content", user_id: user.id }
      end

      it 'returns http created' do
        expect(response).to have_http_status(:created)
      end

      it 'returns the created blog' do
        expect(response.body).to eq(Blog.last.to_json)
      end
    end 

    context 'when the blog is invalid' do
      before do
        post '/blogs', params: { title: "Test Title", content: "Test Content", user_id: nil }
      end

      it 'returns http unprocessable entity' do
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'returns the validation errors' do
        expect(JSON.parse(response.body)).to eq({'user' => ['must exist'] })
      end
    end
  end
end
