class Post < ActiveRecord::Base
  validates :user_id, :title, :body, presence: true
  belongs_to :user
  has_many :tags
end
