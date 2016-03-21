require 'rails_helper'

describe "Route" do

  describe "ChangesSearchable" do
    let!(:sofia_milan) { create :sofia_milan }
    let!(:milan_rome_1) { create :milan_rome_1 }
    let!(:sofia_warsaw) { create :sofia_warsaw }
    let!(:warsaw_milan) { create :warsaw_milan }
    let!(:milan_rome_2) { create :milan_rome_2 }
    let!(:sofia_milan_late) { create :sofia_milan_late }

    it "should find routes with changes" do
      visit root_path
      fill_in "start_point", with: "Sofia"
      fill_in "end_point", with: "Rome"
      fill_in "date-search", with: "2016-03-25"
      click_button "Search"
      expect(page).to have_content("You can get your destination with some changes")
      expect(page).to have_content("1 change")
      expect(page).to have_content("2 changes")
      expect(page).to have_content("March 25, 2016 06:27")
      save_and_open_page
      expect(page).not_to have_content("March 25, 2016 15:30")
    end
  end
end
