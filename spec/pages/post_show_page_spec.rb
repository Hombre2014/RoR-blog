require 'rails_helper'

# rubocop:disable Metrics/BlockLength

RSpec.describe 'Posts show page', type: :system do
  let!(:user) do
    User.create!(
      name: 'Tim',
      email: 'tim@example.com',
      password: '123456',
      confirmed_at: Time.now,
      posts_counter: 3,
      bio: 'Full-stack web developer from Germany'
    )
  end

  let!(:posts) do
    [
      Post.create!(
        author: user,
        title: 'First title',
        text: 'First text',
        likes_counter: 0,
        comments_counter: 0
      ),
      Post.create!(
        author: user,
        title: 'Second title',
        text: 'Second text',
        likes_counter: 0,
        comments_counter: 0
      )
    ]
  end

  let!(:comments) do
    [
      Comment.create!(
        author: user,
        post: posts[1],
        text: 'Comment 1'
      ),
      Comment.create!(
        author: user,
        post: posts[1],
        text: 'Comment 2'
      ),
      Comment.create!(
        author: user,
        post: posts[1],
        text: 'Comment 3'
      ),
      Comment.create!(
        author: user,
        post: posts[1],
        text: 'Comment 4'
      ),
      Comment.create!(
        author: user,
        post: posts[1],
        text: 'Comment 5'
      ),
      Comment.create!(
        author: user,
        post: posts[1],
        text: 'Comment 6'
      )
    ]
  end

  let!(:likes) do
    [
      Like.create!(post: posts[0], author: user),
      Like.create!(post: posts[1], author: user),
      Like.create!(post: posts[1], author: user),
      Like.create!(post: posts[1], author: user)
    ]
  end

  it 'should check to see who is the author of the post' do
    visit '/users/sign_in'
    fill_in 'user_email', with: user.email
    fill_in 'user_password', with: user.password
    click_button 'Log in'
    visit "/users/#{user.id}/posts/#{posts[1].id}"
    expect(page).to have_link(posts[1].author.name)
  end

  it 'should checks to see the correct number of comments' do
    visit '/users/sign_in'
    fill_in 'user_email', with: user.email
    fill_in 'user_password', with: user.password
    click_button 'Log in'
    visit "/users/#{user.id}/posts/#{posts[1].id}"
    expect(page).to have_content(posts[1].comments.length.to_s)
  end

  it 'should check to see the correct number of likes' do
    visit '/users/sign_in'
    fill_in 'user_email', with: user.email
    fill_in 'user_password', with: user.password
    click_button 'Log in'
    visit "/users/#{user.id}/posts/#{posts[1].id}"
    expect(page).to have_content(posts[1].likes.length.to_s)
  end

  it "should check to see all comments author\'s names" do
    visit '/users/sign_in'
    fill_in 'user_email', with: user.email
    fill_in 'user_password', with: user.password
    click_button 'Log in'
    visit "/users/#{user.id}/posts/#{posts[1].id}"
    comments.each do |comment|
      expect(page).to have_content(comment.author.name)
    end
  end
end

# rubocop:enable Metrics/BlockLength
