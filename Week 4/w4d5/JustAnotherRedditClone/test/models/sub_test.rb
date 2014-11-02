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

require 'test_helper'

class SubTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
