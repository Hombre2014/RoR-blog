require 'rails_helper'

RSpec.describe Comment, type: :model do
  before(:all) do
    user = User.create!(name: 'Dick',
                        photo: 'https://unsplash.com/photos/F_-0BxGuVvo',
                        bio: 'Full-stack developer') # , posts_counter: 0
    post = Post.create(author: user, title: 'This is my first post') # , comments_counter: 0, likes_counter: 0
    comment = Comment.create(author: user, post: post, text: 'Welcome in the community, Dick!')
    comment.update_posts_comments_counter
  end

  it 'should increment its post\'s comments_counter with 1' do
    expect(post.comments_counter).to be 1
  end

  it 'should have a post_id' do
    expect(post.comments.post_id).to be_not_nil
  end

  it 'should have an author_id' do
    expect(post.comments.author_id).to be_not_nil
  end

  it 'should have text length longer then 1' do
    expect(post.comments.text.length).to be > 1
  end
end
