require "rails_helper"

describe UserMailer, type: :mailer do

  let!(:user) { create :user }

  describe "password_reset" do

    it "sends user a reset token" do
      user.reset_token = User.new_token
      mail = UserMailer.password_reset(user)
      expect(mail.subject).to eq "Password reset"
      expect(mail.to).to eq [user.email]
      expect(mail.from).to eq ["from@example.com"]
      expect(mail.body.encoded).to have_link "Reset password"
      expect(mail.body.encoded).to have_content user.reset_token
    end
  end

  describe "approve_ticket" do

    it "sends user an approval email" do
      mail = UserMailer.approve_ticket(user)
      expect(mail.subject).to eq "Ticket order approved"
      expect(mail.to).to eq [user.email]
      expect(mail.from).to eq ["from@example.com"]
      expect(mail.body.encoded).to have_link "log in"
    end
  end

  describe "reject_ticket" do

    it "sends user an email with rejection" do
      mail = UserMailer.reject_ticket(user)
      expect(mail.subject).to eq "Ticket order rejected."
      expect(mail.to).to eq [user.email]
      expect(mail.from).to eq ["from@example.com"]
      expect(mail.body.encoded).to have_link "log in"
    end
  end
end
