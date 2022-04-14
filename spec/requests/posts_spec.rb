require 'rails_helper'

RSpec.describe 'Posts', type: :request do
  describe 'GET #index' do
    before(:each) do
      @user = User.create!(name: 'Dick',
                           photo: 'https://unsplash.com/photos/F_-0BxGuVvo',
                           bio: 'Full-stack developer', posts_counter: 0, confirmed_at: Time.now,
                           email: 'test@example.com', password: '123456')
      get user_posts_path user_id: @user.id
    end

    it 'GET requests is success' do
      expect(response).to have_http_status(:ok)
    end

    it 'renders a correct template - index' do
      expect(response).to render_template(:index)
    end

    it 'shows the text "All the posts from a user"' do
      expect(response.body).to include('<h2>All the posts from Dick</h2>')
    end
  end

  # describe 'GET #show' do
  #   before(:each) do
  #     @user = User.create!(name: 'Dick',
  #       photo: 'https://unsplash.com/photos/F_-0BxGuVvo',
  #       bio: 'Full-stack developer', posts_counter: 0, confirmed_at: Time.now,
  #       email: 'test@example.com', password: '123456')
  #     Post.create!(author: @user, title: 'Post 1', text: "Post 1")
  #     get user_post_path user_id: @user.id, id: Post.first.id
  #   end

  #   it 'GET requests is success' do
  #     expect(response).to have_http_status(:ok)
  #   end

  #   it 'renders a correct template - show' do
  #     expect(response).to render_template(:show)
  #   end

  #   it 'shows the text "Single post page - Title"' do
  #     expect(response.body).to include('Single post page - Title')
  #   end
  # end
end
