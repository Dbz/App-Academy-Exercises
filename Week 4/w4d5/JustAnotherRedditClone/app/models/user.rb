# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  username        :string(255)      not null
#  password_digest :string(255)      not null
#  session_token   :string(255)      not null
#  created_at      :datetime
#  updated_at      :datetime
#

class User < ActiveRecord::Base
  validates :username, :password_digest, presence: true
  validates :password, length: { minimum: 6, allow_nil: true }
  validates :username, uniqueness: true
  
  attr_reader :password
  
  before_validation :ensure_session_token
  
  def self.find_by_credentials(username, password)
    user = User.find_by(username: username)
    
    return nil unless user.is_password?(password)
    user
  end
  
  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end
  
  def is_password?(password)
    BCrypt::Password.new(self.password_digest).is_password?(password)
  end
  
  def reset_session_token!
    self.session_token = SecureRandom.base64(16)
    self.save!
    self.session_token
  end
  
  def ensure_session_token
    self.session_token ||= SecureRandom.base64(16)
  end
  
  has_many(
    :posts,
    class_name: "Post",
    foreign_key: :author_id
  )
  has_many(
    :subs,
    class_name: "Sub",
    foreign_key: :moderator_id
  )
  has_many(
    :comments,
    foreign_key: :author_id
  )
end
