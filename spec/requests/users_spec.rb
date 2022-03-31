require 'rails_helper'

RSpec.describe 'Users controller', type: :request do
  describe 'GET #index' do
    before(:each) { get users_path }

    it 'GET requests is a success' do
      expect(response).to have_http_status(:ok)
    end

    it 'renders the correct template - index' do
      expect(response).to render_template(:index)
    end

    it 'includes the text "Welcome to the Ruby on Rails Blog"' do
      expect(response.body).to include('Welcome to the Ruby on Rails Blog')
    end
  end

  describe 'GET #show' do
    before(:each) { get user_path(id: 1) }

    it 'GET requests is success' do
      expect(response).to have_http_status(:ok)
    end

    it 'renders the correct template - show' do
      expect(response).to render_template(:show)
    end

    it 'includes the test "Single user"' do
      expect(response.body).to include('Single user')
    end
  end
end
