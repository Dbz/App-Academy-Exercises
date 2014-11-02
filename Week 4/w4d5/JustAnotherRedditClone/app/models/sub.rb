# == Schema Information
#
# Table name: subs
#
#  id           :integer          not null, primary key
#  title        :string(255)      not null
#  description  :string(255)
#  moderator_id :integer          not null
#  created_at   :datetime
#  updated_at   :datetime
#

class Sub < ActiveRecord::Base
  validates :title, :moderator_id, presence: true
  
  belongs_to(
    :moderator,
    class_name: "User",
    foreign_key: :moderator_id
  )
  has_many :posts
end
