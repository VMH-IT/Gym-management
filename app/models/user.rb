class User < ApplicationRecord
  attr_accessor :remember_token
	before_save { email.downcase!   }
  validates :name, presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },
  									format: 	{ with: VALID_EMAIL_REGEX }
										# unique: true 
  has_secure_password
  validates :password, presence: true, length:  { minimum: 6 } , allow_nil: true
    def self.digest(string)
        cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
        BCrypt::Engine.cost
        BCrypt::Password.create(string, cost: cost)
      end
    
      def self.new_token
        SecureRandom.urlsafe_base64
      end
    
      private
        def create_token  
          self.activation_token = User.new_token
        #   self.activation_digest = User.digest(activation_token)
        end
end
