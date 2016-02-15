class User < ActiveRecord::Base

  include Authenticate

  has_many :tickets
  has_many :routes, through: :tickets

  attr_accessor :remember_token, :reset_token

  before_save :email_downcase
  before_save :role_user

  validates :email, :first_name, :last_name, :phone_number, presence: true
  validates :first_name, :last_name, length: { maximum: 30 }
  validates :email, length: { maximum: 255 },
                              format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
                              uniqueness: { case_sensitive: false }

  has_secure_password                               
  validates :password, presence: true, length: { minimum: 6 }, allow_nil: true
  validates :password_confirmation, presence: true

  enum role: [:user, :admin]

  private
    def email_downcase
      self.email = email.downcase
    end

    def role_user
      self.role = 0
    end

end
