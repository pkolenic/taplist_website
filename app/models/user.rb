class User < ActiveRecord::Base
  # Password Verification
  has_secure_password
  
  # Callbacks
  before_save { email.downcase! }
  
  # Validations
  validates :first_name, presence: true, length: { maximum: 25 }
  validates :last_name, presence: true, length: { maximum: 25 }
  
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
                    
  validates :password, length: { minimum: 6 }
  
  # Convenance Functions
  def full_name
    "#{first_name} #{last_name}"
  end
end
