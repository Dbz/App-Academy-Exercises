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

require 'test_helper'

class PostTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
