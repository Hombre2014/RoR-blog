require 'rails_helper'

RSpec.describe 'Testing Login page', type: :system do
  it 'should render the login page' do
    visit '/users/sign_in'
    expect(page).to have_content('Log in')
  end

  it 'should has email, password fields and login button' do
    visit '/users/sign_in'
    expect(page).to have_field('Email')
    expect(page).to have_field('Password')
    expect(page).to have_button('Log in')
  end

  it 'should have correct user inputs' do
    visit '/users/sign_in'
    User.create!(name: 'Tim', email: 'tim@example.com', password: '123456', confirmed_at: Time.now, posts_counter: 0)
    fill_in 'user_email', with: 'tim@example.com'
    fill_in 'user_password', with: '123456'
    click_button 'Log in'
    expect(page).to have_current_path(root_path)
  end
end
