require 'rails_helper'

RSpec.describe 'Posts', type: :request do
  describe 'GET #index'
  before(:each) { get user_posts_path(user_id: 1) }

  it 'GET requests is success' do
    expect(response).to have_http_status(:ok)
  end

  it 'renders a correct template - index' do
    expect(response).to render_template(:index)
  end

  it 'shows the text "All the posts from a user"' do
    expect(response.body).to include('All the posts from a user')
  end

  describe 'GET #show' do
    before(:each) { get user_post_path(user_id: 1, id: 1) }

    it 'GET requests is success' do
      expect(response).to have_http_status(:ok)
    end

    it 'renders a correct template - show' do
      expect(response).to render_template(:show)
    end

    it 'shows the text "Single post page - Title"' do
      expect(response.body).to include('Single post page - Title')
    end
  end
end
