require 'rails_helper'

RSpec.describe Like, type: :model do
  before(:all) do
    @user = User.create!(name: 'Dick',
      photo: 'https://unsplash.com/photos/F_-0BxGuVvo',
      bio: 'Full-stack developer', posts_counter: 0, confirmed_at: Time.now, email: 'test@example.com', password: '123456') # , posts_counter: 0
    @post = Post.create(author: @user, title: 'This is my first post', text: 'my first post') # , comments_counter: 0, likes_counter: 0
    @like = Like.create(author: @user, post: @post)
    # like.update_posts_likes_counter
  end

  it 'should increment its post\'s likes_counter with 1' do
    expect(@post.likes_counter).to be 1
  end

  it 'should have a post_id' do
    expect(@like.post_id).to eq @post.id
  end

  it 'should have an author_id' do
    expect(@like.author_id).to eq @user.id
  end
end
