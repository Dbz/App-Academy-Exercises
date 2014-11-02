# == Schema Information
#
# Table name: posts
#
#  id         :integer          not null, primary key
#  title      :string(255)      not null
#  content    :text             not null
#  sub_id     :integer          not null
#  author_id  :integer          not null
#  created_at :datetime
#  updated_at :datetime
#

class Post < ActiveRecord::Base
  validates :title, :content, :author_id, :sub_id, presence: true
  validates :title, uniqueness: true
  
  belongs_to(
    :author,
    class_name: "User",
    foreign_key: :author_id
  )
  belongs_to :sub
  has_many :comments
  
  
  def top_level_comments
    self.comments.select { |comment| comment.parent_comment_id == nil }
  end
end
