module Authenticate
  extend ActiveSupport::Concern

  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end

  def forget
    update_attribute(:remember_digest, nil)
  end

  def authenticated?(attribute, token)
    digest = send("#{attribute}_digest")
    return false if digest.nil?    
    BCrypt::Password.new(digest).is_password?(token)
  end

  #password reset
  def create_reset_digest
    self.reset_token = User.new_token
    update_columns(reset_digest: User.digest(reset_token),
                                reset_sent_at: Time.zone.now)
  end

  def send_password_reset_email
    UserMailer.password_reset(self).deliver_now
  end

  def password_reset_expired?
    reset_sent_at < 15.minutes.ago
  end
  
  module ClassMethods
    def new_token
      SecureRandom.urlsafe_base64
    end

    def digest(token)
      cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                                                      BCrypt::Engine.cost
      BCrypt::Password.create(token, cost: cost)
    end
  end

end
