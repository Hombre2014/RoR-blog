class Comment < ApplicationRecord
  belongs_to :author, class_name: 'User'
  belongs_to :post

  after_save :update_posts_comments_counter

  private

  def update_posts_comments_counter
    post.increment!(:comments_counter)
  end

  validates :author_id, presence: true
  validates :post_id, presence: true
  validates :text, presence: true, length: { minimum: 1 }
end
