class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable
  has_many :posts, foreign_key: :author_id
  has_many :comments
  has_many :likes

  validates :name, presence: true
  # validates :posts_counter, numericality: { greater_than_or_equal_to: 0, only_integer: true }

  default_scope { order(created_at: :desc) }

  def latest_posts
    posts.order(created_at: :desc).limit(3).to_a
  end
end
