class Post < ApplicationRecord
  belongs_to :author, class_name: 'User'
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy

  validates :title, length: { in: 1..250 }, presence: true, allow_blank: false
  validates :text, presence: true, length: { in: 1..2500 }

  def last_5_comments
    comments.order(created_at: :desc).includes(:author).limit(5)
  end

  after_save :update_users_posts_counter

  private

  def update_users_posts_counter
    author.increment!(:posts_counter)
  end
end
