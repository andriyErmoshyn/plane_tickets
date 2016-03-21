require 'rails_helper'

describe Route do

  let!(:route) { create :route }

  it "has a valid factory" do
    expect(route).to be_valid
  end

  it { is_expected.to validate_presence_of :start_point }
  it { is_expected.to validate_presence_of :end_point }
  it { is_expected.to validate_presence_of :depart }
  it { is_expected.to validate_presence_of :arrive }
  it { is_expected.to validate_presence_of :price }
  it { is_expected.to validate_presence_of :route_number }

  it { is_expected.to validate_uniqueness_of(:route_number).case_insensitive }

  it { is_expected.to have_many(:users).through(:tickets) }
  it { is_expected.to have_many(:tickets).dependent(:destroy) }

  describe "#duration" do
    subject { route }
    specify{expect(route.arrive-route.depart).to eq route.duration}
  end

  describe "#formatted_duration" do
    let(:route) { create(:route, depart: "2016-03-10 12:00", arrive: "2016-03-10 14:20") }
    it "should " do
      expect(route.formatted_duration).to eq "2 hours 20 mins"
    end
  end

  describe "#free_seats" do
    subject { route }

    it "when 1 ticket for the route had bought" do
      route.tickets.create
      expect(route.free_seats).to eq 4
    end
  end

  describe "#sold_out?" do
    subject { route }

    it "when 5 tickets of 5 available for the route had bought" do
      route.seats = 5
      5.times { route.tickets.create }
      expect(route.sold_out?).to be_truthy
    end
  end
end
