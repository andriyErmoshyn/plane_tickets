require "rails_helper"

describe SessionsController do

  let!(:user) { create :user }

  it "saves remember_token " do
    log_in(user)
    expect(cookies["remember_token"]).not_to be_nil
    expect(response).to redirect_to(root_path)
  end

  it "doesn't save remember_token " do
    log_in(user, remember_me: 0)
    expect(cookies["remember_token"]).to be_nil
  end
end
