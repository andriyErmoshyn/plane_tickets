require 'rails_helper'

describe "User" do

  let(:user) {create :user }
  let(:admin) { create :admin }

  describe "when signs up" do
    it "should see sign up link" do
      visit signup_path
      expect(page). to have_content("Sign up")
    end

    context "with valid data" do
      it "should sign up successfully" do
        expect{
        visit signup_path
        fill_in "Email", with: "test@email.com"
        fill_in "First name", with: "James"
        fill_in "Last name", with: "Bond"
        fill_in "Phone number", with: "380504789999"
        fill_in "Password", with: "password"
        fill_in "Confirm password", with: "password"
        click_button "Sign up"}.to change(User, :count).by(1)

        expect(page).to have_content("You signed up successfully!")
        expect(current_path).to eq root_path
        expect(page).to have_link("Log out", href: logout_path)
        expect(page).to have_selector("#profile_link", text:"test@email.com")
      end
    end

    context "with invalid data" do
      it "should render signup page" do
        visit signup_path
        fill_in "Email", with: "Unlogged"
        fill_in "First name", with: ""
        click_button "Sign up"

        expect(page).to have_content("Sign up")
        expect(page).to have_css('div.alert.alert-danger', text: "Something went wrong.")
      end
    end
  end

  describe "log in" do
    subject { user }

    it "with valid login and password" do
      log_in_with(user.email, user.password)

      expect(page).to have_content("You logged in successfully!")
      expect(current_path).to eq root_path
    end

    it "with unvalid login" do
      log_in_with("Nobody", "password")

      expect(page). to have_content("Invalid login/password information.")
    end

    it "with unvalid password" do
      log_in_with(user.email, "invalid_password")

      expect(page). to have_content("Invalid login/password information.")
    end

    context "when admin" do

      it "should be redirected to admin/routes" do
        log_in_with(admin.email, admin.password)

        expect(current_path).to eq admin_routes_path
      end
    end
  end

  describe "log out" do

    subject { user }

    it "logs out successfully" do
      log_in_with(user.email, user.password)
      click_link "Log out"

      expect(current_path).to eq root_path
      expect(page).to have_link("Log in")
    end
  end

  describe "as a logged-in user" do

    subject { user }
    let!(:route) { create(:route, depart: "2016-03-10 15:00", arrive: "2016-03-10 16:35")}

    before { log_in_with(user.email, user.password) }

    context "when has no ticket for actual route" do
      it "should be able to buy a ticket" do
        fill_in "date-search", with: "2016-03-10"
        click_button "Search"

        expect(page).to have_button("Buy a ticket")
      end
    end

    context "when has a ticket for actual route" do
      let!(:ticket) { create(:ticket, user: user, route: route) }

      it "should be able to buy a ticket" do
        fill_in "date-search", with: "2016-03-10"
        click_button "Search"

        expect(page).to have_button("You have one")
      end
    end

    describe "#update" do

      context "with valid data" do
        it "should be able to edit own profile" do
          visit edit_user_path(user)
          fill_in "First name", with: "New name"
          fill_in "Password", with: "password"
          fill_in "Confirm password", with: "password"
          click_button "Update profile"

          expect(page).to have_content("Profile updated")
          expect(user.reload.first_name).to eq "New name"
        end
      end

      context "with invalid data" do
        it "should get an error flash" do
          visit edit_user_path(user)
          fill_in "First name", with: " "
          fill_in "Password", with: "password"
          fill_in "Confirm password", with: "password"
          click_button "Update profile"

          expect(page).to have_css('div.alert.alert-danger', text: "Something went wrong.")
          expect(page).to have_content("Edit profile")
        end
      end
    end

    describe "#verify_admin" do

      context "when tries to get restricted admin area" do
        it "should be redirected to the root_path" do
          visit admin_routes_path

          expect(page).to have_css('div.alert.alert-warning', text: "Sorry, you have no rights for this action.")
          expect(current_path).to eq root_path
        end
      end
    end
  end

  describe "PasswordResets " do

    subject { user }

    describe "#create" do

      before { visit new_password_reset_path }

      context "with valid email" do

        it "sends member a password reset link" do
          fill_in "Email", with: user.email
          click_button("Submit")
          expect(page).to have_content("Email sent with password reset instructions")
        end
      end

      context "with invalid email" do

        it "shows the error message" do
          fill_in "Email", with: "ivalid_email"
          click_button("Submit")
          expect(page).to have_content("Email address not found")
        end
      end
    end
  end
end
