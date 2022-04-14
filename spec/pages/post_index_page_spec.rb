require 'rails_helper'

# rubocop:disable Metrics/BlockLength

RSpec.describe 'Posts index page', type: :system do
  let!(:user) do
    User.create!(
      name: 'Tim',
      email: 'tim@example.com',
      password: '123456',
      confirmed_at: Time.now,
      posts_counter: 0,
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
      ),
      Post.create!(
        author: user,
        title: 'Third title',
        text: 'Third text',
        likes_counter: 0,
        comments_counter: 0
      ),
      Post.create!(
        author: user,
        title: 'Fourth title',
        text: 'Fourth text',
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
      Like.create!(post: posts[1], author: user),
      Like.create!(post: posts[1], author: user),
      Like.create!(post: posts[1], author: user),
      Like.create!(post: posts[0], author: user)
    ]
  end

  it 'should check to see if there is a username' do
    visit '/users/sign_in'
    fill_in 'user_email', with: user.email
    fill_in 'user_password', with: user.password
    click_button 'Log in'
    visit "/users/#{user.id}/posts"
    expect(page).to have_content(user.name)
  end

  it 'should check to see if there is a correct number of posts' do
    visit '/users/sign_in'
    fill_in 'user_email', with: user.email
    fill_in 'user_password', with: user.password
    click_button 'Log in'
    visit "/users/#{user.id}/posts"
    expect(page).to have_content("Number of posts: #{user.posts_counter}")
  end

  it 'should check to see if all the post have titles' do
    visit '/users/sign_in'
    fill_in 'user_email', with: user.email
    fill_in 'user_password', with: user.password
    click_button 'Log in'
    visit "/users/#{user.id}/posts"
    posts.each do |post|
      expect(page).to have_content(post.title)
    end
  end

  it 'should check to se if there all post have texts' do
    visit '/users/sign_in'
    fill_in 'user_email', with: user.email
    fill_in 'user_password', with: user.password
    click_button 'Log in'
    visit "/users/#{user.id}/posts"
    posts.each do |post|
      expect(page).to have_content(post.text)
    end
  end

  it 'should check to see only the last 5 comments' do
    visit '/users/sign_in'
    fill_in 'user_email', with: user.email
    fill_in 'user_password', with: user.password
    click_button 'Log in'
    visit "/users/#{user.id}/posts"
    5.times do |i|
      expect(page).to have_content(comments[i + 1].text)
    end
    expect(page).not_to have_content(comments[0].text)
  end

  it 'should check that the number of likes are correct' do
    visit '/users/sign_in'
    fill_in 'user_email', with: user.email
    fill_in 'user_password', with: user.password
    click_button 'Log in'
    visit "/users/#{user.id}/posts"
    expect(page).to have_content(posts[1].likes.length.to_s)
    expect(page).to have_content(posts[0].likes.length.to_s)
  end

  it 'should check to see if there is a button labeled Next' do
    visit '/users/sign_in'
    fill_in 'user_email', with: user.email
    fill_in 'user_password', with: user.password
    click_button 'Log in'
    visit "/users/#{user.id}/posts"
    expect(page).to have_button('Next')
  end

  it 'should check if clicking  on the post\'s title loads its page' do
    visit '/users/sign_in'
    fill_in 'user_email', with: user.email
    fill_in 'user_password', with: user.password
    click_button 'Log in'
    visit "/users/#{user.id}/posts"
    click_link posts[1].title
    expect(page).to have_current_path("/users/#{user.id}/posts/#{posts[1].id}")
  end
end

# rubocop:enable Metrics/BlockLength
