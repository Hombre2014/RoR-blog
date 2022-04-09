require 'rails_helper'

RSpec.describe Like, type: :model do
  before(:all) do
    user = User.create!(name: 'Dick',
                        photo: 'https://unsplash.com/photos/F_-0BxGuVvo',
                        bio: 'Full-stack developer') # , posts_counter: 0
    post = Post.create(author: user, title: 'This is my first post') # , comments_counter: 0, likes_counter: 0
    like = Like.create(author: user, post: post)
    like.update_posts_likes_counter
  end

  it 'should increment its post\'s likes_counter with 1' do
    expect(post.likes_counter).to be 1
  end

  it 'should have a post_id' do
    expect(post.likes.post_id).to be_not_nil
  end

  it 'should have an author_id' do
    expect(post.likes.author_id).to be_not_nil
  end
end
