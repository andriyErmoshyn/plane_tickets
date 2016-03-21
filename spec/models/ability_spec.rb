require "rails_helper"
require "cancan/matchers"

describe Ability do
  let(:admin) { create :admin }
  let(:user) { create :user }
  let(:non_logged_in_user) { build :non_logged_in_user }

  context "with user's role 'admin'" do
    subject { Ability.new(admin) }

    it { is_expected.to be_able_to(:update, admin) }
    it { is_expected.not_to be_able_to(:update, user) }
  end

  context "with user's role 'user'" do
    subject { Ability.new(user) }

    it { is_expected.to be_able_to(:update, user) }
    it { is_expected.to be_able_to(:read, user) }
  end

  context "with non-logged in user" do
    subject { Ability.new(non_logged_in_user) }

    it { is_expected.to be_able_to(:create, User) }
    it { is_expected.not_to be_able_to(:read, User) }
  end

end
