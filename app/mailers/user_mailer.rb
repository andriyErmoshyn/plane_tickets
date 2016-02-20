class UserMailer < ApplicationMailer

  def password_reset(user)
    @user = user

    mail to: user.email, subject: "Password reset"
  end

  def approve_ticket(user)
    @user = user

    mail to: user.email, subject: "Ticket order approved"
  end

  def reject_ticket(user)
    @user = user

    mail to: user.email, subject: "Ticket order rejected."
  end

end
