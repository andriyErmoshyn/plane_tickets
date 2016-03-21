require 'rails_helper'

describe "Admin" do
  let(:admin) { create :admin }
  let(:user) { create :user }
  let(:route)  { create :route }
  let(:ticket)  { create :ticket }

  before { log_in_with(admin.email, admin.password) }

  describe "tickets" do

    describe "when visits tickets page" do

      let!(:older_ticket) do
        create(:ticket, created_at: 3.hours.ago)
      end
      let!(:newer_ticket) do
        create(:ticket, created_at: 2.hours.ago)
      end

      it "should see all tickets in descending order" do
        tickets = Ticket.all
        click_link "Tickets", href: admin_tickets_path

        expect(page).to have_content("All tickets")
        expect(tickets).to eq [newer_ticket, older_ticket]
      end
    end

    describe "#update" do

      let!(:approved_ticket) { create :ticket }
      let!(:rejected_ticket) { create :ticket }
      before { visit admin_tickets_path}

      context "when approved" do
        it "should change ticket status to 'approved'" do
          # save_and_open_page
          choose("status_approved_#{approved_ticket.id}")
          # click_button "Send email"
          find_button("send_email_#{approved_ticket.id}").click

          expect(page).to have_content("Approved")
        end
      end

      context "when rejected" do
        it "should change ticket status to 'rejected'" do
          choose("status_rejected_#{rejected_ticket.id}")
          # click_button "Send email"
          find_button("send_email_#{rejected_ticket.id}").click

          expect(page).to have_content("Rejected")
        end
      end
    end
  end
end
