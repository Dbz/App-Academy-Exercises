class Tag < ActiveRecord::Base
  validates :name, :post_id, presence: true
  belongs_to :post
end
