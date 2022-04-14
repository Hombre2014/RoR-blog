require 'rails_helper'

RSpec.describe 'Users show page', type: :system do
  let!(:user) do
    User.create!(
      name: 'Tom',
      email: 'tom@example.com',
      password: '123456',
      confirmed_at: Time.now,
      posts_counter: 4,
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

  it 'should check to see the user\'s username' do
    visit '/users/sign_in'
    fill_in 'user_email', with: user.email
    fill_in 'user_password', with: user.password
    click_button 'Log in'
    visit "/users/#{user.id}"
    expect(page).to have_content(user.name)
  end

  it 'should check to see the correct number of posts' do
    visit '/users/sign_in'
    fill_in 'user_email', with: user.email
    fill_in 'user_password', with: user.password
    click_button 'Log in'
    visit "/users/#{user.id}"
    expect(page).to have_content("Number of posts: #{user.posts_counter}")
  end

  it 'should check to see that the user has a bio' do
    visit '/users/sign_in'
    fill_in 'user_email', with: user.email
    fill_in 'user_password', with: user.password
    click_button 'Log in'
    visit "/users/#{user.id}"
    expect(page).to have_content(user.bio)
  end

  it 'should check to see the first 3 posts' do
    visit '/users/sign_in'
    fill_in 'user_email', with: user.email
    fill_in 'user_password', with: user.password
    click_button 'Log in'
    visit "/users/#{user.id}"
    3.times do |i|
      expect(page).to have_content(posts[i].title)
      expect(page).to have_content(posts[i].text)
    end
  end

  it 'should verify that there is a link "See all posts"' do
    visit '/users/sign_in'
    fill_in 'user_email', with: user.email
    fill_in 'user_password', with: user.password
    click_button 'Log in'
    visit "/users/#{user.id}"
    expect(page).to have_link('See all posts')
  end

  it 'should verify that clicking on "See all posts" goes to the right page' do
    visit '/users/sign_in'
    fill_in 'user_email', with: user.email
    fill_in 'user_password', with: user.password
    click_button 'Log in'
    visit "/users/#{user.id}"
    click_link 'See all posts'
    expect(page).to have_current_path("/users/#{user.id}/posts")
  end
end
