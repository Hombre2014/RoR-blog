require 'rails_helper'

RSpec.describe Comment, type: :model do
  before(:all) do
    user = User.create!(name: 'Dick',
                        photo: 'https://unsplash.com/',
                        bio: 'Full-stack developer', posts_counter: 1, confirmed_at: Time.now,
                        email: 'test@example.com', password: '123456')
    @post = Post.create(author: user, title: 'This is my first post', text: 'my first text')
    Comment.create!(author: user, post: @post, text: 'Welcome in the community, Dick!')
  end

  it 'should increment its post\'s comments_counter with 1' do
    expect(@post.comments_counter).to eq 1
  end

  it 'should have a post_id' do
    expect(@post.comments.first.post_id).should_not be_nil
  end

  it 'should have an author_id' do
    expect(@post.comments.first.author_id).should_not be_nil
  end

  it 'should have text length longer then 1' do
    expect(@post.comments.first.text).to eq 'Welcome in the community, Dick!'
  end
end
