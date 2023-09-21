class Post < ApplicationRecord
  belongs_to :author, class_name: 'User', foreign_key: 'author_id'
  has_many :comments
  has_many :likes

  def post_counter_updates
    author.update(posts_counter: author.posts.count)
  end

  def latest_comments
    comments.order(created_at: :desc).limit(5)
  end

  after_create :post_counter_updates
  after_destroy :post_counter_updates
end
