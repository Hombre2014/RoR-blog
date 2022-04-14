require 'rails_helper'

RSpec.describe 'Users controller', type: :request do
  describe 'GET #index' do
    before(:each) do
      @user = User.create!(name: 'Dick',
        photo: 'https://unsplash.com/photos/F_-0BxGuVvo',
        bio: 'Full-stack developer', posts_counter: 0, confirmed_at: Time.now, email: 'test@example.com', password: '123456')
        get users_path
    end

    it 'GET requests is a success' do
      expect(response).to have_http_status(:ok)
    end

    it 'renders the correct template - index' do
      expect(response).to render_template(:index)
    end

    it 'includes the text "Welcome to the Ruby on Rails Blog"' do
      expect(response.body).to include('<h3><a class="user-link" href="/users/3">Dick</a></h3>')
    end
  end

  describe 'GET #show' do
    before(:each) do
      @user = User.create!(name: 'Dick',
        photo: 'https://unsplash.com/photos/F_-0BxGuVvo',
        bio: 'Full-stack developer', posts_counter: 0, confirmed_at: Time.now, email: 'test@example.com', password: '123456')
        get user_path id: @user.id
    end

    it 'GET requests is success' do
      expect(response).to have_http_status(:ok)
    end

    it 'renders the correct template - show' do
      expect(response).to render_template(:show)
    end

    it 'includes the test "Single user"' do
      expect(response.body).to include('Dick')
    end
  end
end
