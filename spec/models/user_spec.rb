require "rails_helper"

describe User do

  let!(:user) { create :user }

  it "has a valid factory" do
    expect(user).to be_valid
  end

  it { is_expected.to validate_presence_of :email }
  it { is_expected.to validate_presence_of :first_name }
  it { is_expected.to validate_presence_of :last_name }
  it { is_expected.to validate_presence_of :phone_number }
  it { is_expected.to validate_presence_of :password }
  it { is_expected.to validate_presence_of :password_confirmation }

  it { is_expected.to validate_uniqueness_of(:email).case_insensitive }

  it { is_expected.to validate_length_of(:first_name).is_at_most(30) }
  it { is_expected.to validate_length_of(:last_name).is_at_most(30) }
  it { is_expected.to validate_length_of(:email).is_at_most(255) }
  it { is_expected.to validate_length_of(:password).is_at_least(6) }

  it { is_expected.to have_secure_password }

  it { is_expected.to validate_confirmation_of(:password) }

  it { is_expected.to have_many(:routes).through(:tickets) }
  it { is_expected.to have_many(:tickets).dependent(:destroy) }


  it  { is_expected.to define_enum_for(:role) }

  describe "email format validations" do

    it "is invalid with invalid email" do
      addresses = %w[user@foo,com user_at_foo.org example.user@foo.
                   foo@bar_baz.com foo@bar+baz.com]
      addresses.each do |invalid_address|
        user.email = invalid_address
        expect(user).not_to be_valid
      end
    end

    it "is valid with valid email" do
      addresses = %w[user@foo.COM A_US-ER@f.b.org frst.lst@foo.jp a+b@baz.cn]
      addresses.each do |valid_address|
        user.email = valid_address
        expect(user).to be_valid
      end
    end
  end

  describe "#authenticate" do
    subject { user }
    let(:found_user) { User.find_by(email: user.email) }

    context "with valid password" do
      it { is_expected.to eq found_user.authenticate(user.password) }
    end

    context "with invalid password" do
      let(:user_for_invalid_password) { found_user.authenticate("invalid") }
      it { is_expected.not_to eq user_for_invalid_password }
      specify { expect(user_for_invalid_password).to be_falsey }
    end
  end

  describe "authenticated? should return false for a user with nil digest" do
    subject{ user }
    specify { expect(user.authenticated?(:reset, '')).to be_falsey }
  end

  describe '#send_password_reset_email' do

    it "should be successful" do
      user.reset_token = User.new_token
      expect{ user.send_password_reset_email }.to change{ ActionMailer::Base.deliveries.count }.by(1)
    end
  end

  describe "#role_user" do
    let(:user) { build :non_logged_in_user }

    it "should define role 'user' before save" do
      user.save
      expect(user.role).to eq "user"
    end
  end

  describe "#bought_ticket?" do
    let(:route) {create :route}

    it "should be true when the user bought a ticket" do
      user.tickets.create(route_id: route.id)
      expect(user.bought_ticket?(route)).to be_truthy
    end
  end
end
