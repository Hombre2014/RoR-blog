require 'rails_helper'

RSpec.describe 'Users index page', type: :system do
  let!(:users) do
    [
      User.create!(
        name: 'Tim',
        email: 'tim@example.com',
        password: '123456',
        confirmed_at: Time.now,
        posts_counter: 1
      ),
      User.create!(
        name: 'Tom',
        email: 'tom@example.com',
        password: '123456',
        confirmed_at: Time.now,
        posts_counter: 2
      ),
      User.create!(
        name: 'Anna',
        email: 'anna@example.com',
        password: '123456',
        confirmed_at: Time.now,
        posts_counter: 3
      )
    ]
  end

  it 'should check to see if all of the users are displayed' do
    visit '/users/sign_in'
    fill_in 'user_email', with: users[0].email
    fill_in 'user_password', with: users[0].password
    click_button 'Log in'
    users.each do |user|
      expect(page).to have_content(user.name)
    end
  end

  it 'should check to see the correct number of posts' do
    visit '/users/sign_in'
    fill_in 'user_email', with: users[0].email
    fill_in 'user_password', with: users[0].password
    click_button 'Log in'
    users.each do |user|
      expect(page).to have_content("Number of posts: #{user.posts_counter}")
    end
  end
end
