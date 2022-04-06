class Post < ApplicationRecord
  belongs_to :author, class_name: 'User'
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy

  def last_5_comments
    comments.order(created_at: :desc).limit(5)
  end

  after_save :update_users_posts_counter

  private

  def update_users_posts_counter
    author.increment!(:posts_counter)
  end

  validates :title, presence: true
  validates :text, presence: true, length: { minimum: 1 }
end
