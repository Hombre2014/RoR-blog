require 'rails_helper'

RSpec.describe Post, type: :model do
  before(:all) do
    user = User.create!(name: 'Dick',
                        photo: 'https://unsplash.com/photos/F_-0BxGuVvo',
                        bio: 'Full-stack developer') # , posts_counter: 0
    Post.create(author: user, title: 'This is my first post') # , comments_counter: 0, likes_counter: 0
  end

  it 'should updates its user\'s posts_counter' do
    post.update_users_posts_counter
    expect(user.posts_counter).to be 1
  end

  it 'should get user\'s 5 most recent comments' do
    comment1 = Comment.create!(post: post, author: user, text: 'Hi 1')
    comment2 = Comment.create!(post: post, author: user, text: 'Hi 2')
    comment3 = Comment.create!(post: post, author: user, text: 'Hi 3')
    comment4 = Comment.create!(post: post, author: user, text: 'Hi 4')
    comment5 = Comment.create!(post: post, author: user, text: 'Hi 5')
    last_five_comments = post.last_5_comments
    expect(last_five_comments.length).to be 5
    expect(last_five_comments[0].id).to be comment1.id
    expect(last_five_comments[1].id).to be comment2.id
    expect(last_five_comments[2].id).to be comment3.id
    expect(last_five_comments[3].id).to be comment4.id
    expect(last_five_comments[4].id).to be comment5.id
  end

  it 'should not have a title nil' do
    expect(post.title).to be_not_nil
  end

  it 'should not have a title that exceed 250 characters.' do
    post.title = 'a' * 260
    expect(post.title).to_not be_valid
  end

  it 'should have comments_counter an integer greater than or equal to 0' do
    expect(post.comments_counter) >= 0
  end

  it 'should have likes_counter an integer greater than or equal to 0' do
    Like.create(author: user, post: post)
    expect(post.likes_counter).to >= 0
  end
end