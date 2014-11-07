
class User < ActiveRecord::Base
  validates :user_name, :password_digest, :session_token,
    presence: true

    before_validation :ensure_session_token
    
  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end

  def is_password?(password)
    BCrypt::Password.new(self.password_digest).is_password?(password)
  end

  def self.find_by_credentials(user_name, password)
    user = self.find_by(user_name: user_name)
    return unless user
    if user.is_password?(password)
      user
    else
      nil
    end
  end
  
  def ensure_session_token
    self.session_token = SecureRandom.base64(16)
  end

  has_many :cat_rental_requests
  has_many :cats

end

