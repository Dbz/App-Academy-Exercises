# == Schema Information
#
# Table name: users
#
#  id         :integer          not null, primary key
#  created_at :datetime
#  updated_at :datetime
#  username   :string(255)
#

class User < ActiveRecord::Base
  has_many(:contacts)
  has_many(:contact_shares, dependent: :destroy)
  has_many(
    :shared_contacts,
    through: :contact_shares,
    source: :contact
  )
end
