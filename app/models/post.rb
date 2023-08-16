class Post < ApplicationRecord
  belongs_to :author, class_name: 'User'
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  validates :title, presence: true, length: { maximum: 250 }
  validates :comments_counter, numericality: { greater_than_or_equal_to: 0, allow_nil: true }
  validates :likes_counter, numericality: { greater_than_or_equal_to: 0, allow_nil: true }

  after_save :update_posts_count

  def recent_comments(limit = 5)
    comments.order(created_at: :desc).limit(limit)
  end

  private

  def update_posts_count
    author.increment!(:posts_counter)
  end
end
