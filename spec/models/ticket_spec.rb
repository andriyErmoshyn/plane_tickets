require 'rails_helper'

describe Ticket do

  let!(:ticket) { create :ticket }

  it "has a valid factory" do
    expect(ticket).to be_valid
  end

  it { is_expected.to belong_to(:user) }
  it { is_expected.to belong_to(:route) }

  it  { is_expected.to define_enum_for(:status) }

end
