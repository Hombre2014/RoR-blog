require 'rails_helper'

RSpec.describe User, type: :model do
  before(:all) do
    @user = User.create!(name: 'Dick',
                         photo: 'https://unsplash.com/photos/F_-0BxGuVvo',
                         bio: 'Full-stack developer', posts_counter: 1, confirmed_at: Time.now,
                         email: 'test@example.com', password: '123456')
    Post.create!(author: @user, title: 'Title 1', text: 'This is my first post')
    Post.create!(author: @user, title: 'Title 2', text: 'This is my second post')
    Post.create!(author: @user, title: 'Title 3', text: 'This is my third post')
  end

  it 'should have a name not equal to nil' do
    expect(@user.name).to_not be_nil
  end

  it 'should have a post counter higher or grater than 0' do
    expect(@user.posts_counter).to be >= 0
  end

  it 'should shows the last three posts when method last_3_posts is called' do
    last_3_posts = @user.last_3_posts
    expect(last_3_posts[0].title).to eq 'Title 3'
    expect(last_3_posts[1].title).to eq 'Title 2'
    expect(last_3_posts[2].title).to eq 'Title 1'
  end
end
