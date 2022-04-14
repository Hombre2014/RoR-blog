require 'rails_helper'

# rubocop:disable Metrics/BlockLength

RSpec.describe 'Testing posts views', type: :feature do
  describe 'post#show views' do
    before(:each) do
      first_user = User.create!(name: 'Tom', photo: 'photo.jpg', bio: 'Teacher from Mexico.', email: 'to@example.com',
                                password: 'password', confirmed_at: Time.now, posts_counter: 0)
      (1..5).each { |i| first_user.posts.create title: "Post number #{i}", text: "This is my #{i} post!" }
      Comment.create! author: first_user, post: Post.last, text: 'Hi, tom!'
      Like.create! author: first_user, post: Post.last
      visit user_session_path
      fill_in 'Email',	with: 'to@example.com'
      fill_in 'Password',	with: 'password'
      click_button 'Log in'
      visit user_post_path user_id: first_user.id, id: Post.last.id
    end

    it "I can see the post's title." do
      expect(page).to have_content 'Post number 5'
    end

    it 'I can see who wrote the post.' do
      expect(page).to have_content 'by Tom'
    end

    it 'I can see how many comments it has.' do
      expect(page).to have_content 'Comments: 1'
    end

    it 'I can see how many likes it has.' do
      expect(page).to have_content 'Likes: 1'
    end

    it 'I can see the post body.' do
      expect(page).to have_content 'This is my 5 post!'
    end

    it 'I can see the username of each commentor.' do
      expect(page).to have_content 'Tom:'
    end
    it 'I can see the comment each commentor left' do
      expect(page).to have_content 'Hi, tom!'
    end
  end
end

# rubocop:enable Metrics/BlockLength
