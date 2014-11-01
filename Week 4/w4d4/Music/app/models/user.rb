class User < ActiveRecord::Base
  validates :email, uniqueness: true
  validates :password_digest, length: { minimum: 6, allow_nil: true }
  after_initialize :ensure_session_token
  
  def self.generate_session_token
    token = SecureRandom.base64(16)
  end
  
  def self.find_by_credentials(email, password)
    user = User.find_by(email: email)
    if user.is_password?(password)
      user
    else
      nil
    end
  end
  
  def reset_session_token!
    self.session_token = User.generate_session_token
    save!
  end
  
  def ensure_session_token
    self.session_token ||= User.generate_session_token
  end
  
  def password=(password)
    self.password_digest = BCrypt::Password.create(password)
  end
  
  def is_password?(password)
    BCrypt::Password.new(password_digest).is_password?(password)
  end
  
  has_many :notes
  
end