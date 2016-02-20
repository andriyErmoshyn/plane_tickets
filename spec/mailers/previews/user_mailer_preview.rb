# Preview all emails at http://localhost:3000/rails/mailers/user_mailer
class UserMailerPreview < ActionMailer::Preview
  
  def password_reset
    user = User.first
    user.reset_token = User.new_token
    UserMailer.password_reset(user)
  end

  def approve_ticket
    user = User.first
    UserMailer.approve_ticket(user)
  end

  def reject_ticket
    user = User.first
    UserMailer.reject_ticket(user)
  end  

end
