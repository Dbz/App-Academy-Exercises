# == Schema Information
#
# Table name: comments
#
#  id                :integer          not null, primary key
#  content           :text             not null
#  author_id         :integer          not null
#  post_id           :integer          not null
#  parent_comment_id :integer
#  created_at        :datetime
#  updated_at        :datetime
#

class Comment < ActiveRecord::Base
  validates :content, :author_id, :post_id, presence: true
  belongs_to :post
  belongs_to(
    :parent,
    class_name: "Comment",
    foreign_key: :parent_comment_id
  )
  has_many(
    :children,
    class_name: "Comment",
    foreign_key: :parent_comment_id
  )
  belongs_to(
    :author,
    class_name: "User",
    foreign_key: :author_id
  )
  
  def children_comments
    return self if self.comments.empty?
    self.comments.map { |c| c.children_comments }
  end
end
