class ContactShare < ActiveRecord::Base
  validates :contact_id, :user_id, presence: true
  validates :user_id, uniqueness: { scope: :id }
  
 
  belongs_to(:contact)
  belongs_to(:user)
end