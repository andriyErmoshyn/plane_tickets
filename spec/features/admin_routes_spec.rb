require 'rails_helper'

describe "Admin" do
  let(:admin) { create :admin }
  let(:route)  { create :route }

  before { log_in_with(admin.email, admin.password) }

  describe "routes" do

    describe "#new" do

      it "should render the 'new' template" do
        click_link "New route", href: new_admin_route_path

        expect(current_path).to eq new_admin_route_path
        expect(page).to have_content("Add new route")
      end
    end

    describe "#create" do
      before { visit new_admin_route_path }

      context "with valid data" do
        it "should be successfull" do
          expect{
          fill_in "Route number", with: "101"
          fill_in "Start point", with: "Kyiv"
          fill_in "End point", with: "Lviv"
          fill_in "Depart", with: "2016-03-10 08:00"
          fill_in "Arrive", with: "2016-03-10 09:01"
          fill_in "Price", with: "30.00"
          fill_in "Seats", with: "5"
          click_button "Create route" }.to change(Route, :count).by(1)

          expect(page).to have_css('div.alert.alert-success', text: "Successfully created...")
          expect(current_path).to eq admin_routes_path
        end
      end

      context "with invalid data" do
        it "should render the 'new' template" do
          expect{
          fill_in "Start point", with: ""
          fill_in "End point", with: ""
          click_button "Create route" }.not_to change(Route, :count)

          expect(page).to have_css('div.alert.alert-danger', text: "Something went wrong.")
        end
      end
    end

    describe "#update" do
      before { visit edit_admin_route_path(route) }

      context "with valid data" do
        it "should be successfull" do
          fill_in "Route number", with: "1011"
          fill_in "Start point", with: "Odessa"
          click_button "Edit route"

          expect(page).to have_css('div.alert.alert-success', text: "Route updated")
          expect(route.reload.route_number).to eq "1011"
          expect(route.reload.start_point).to eq "Odessa"
        end
      end

      context "with invalid data" do
        it "should get an error flash" do
          fill_in "Route number", with: "1011"
          fill_in "Start point", with: ""
          click_button "Edit route"

          expect(page).to have_css('div.alert.alert-danger', text: "Something went wrong.")
        end
      end
    end

  end
end
