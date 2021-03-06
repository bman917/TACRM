require 'spec_helper'

describe "Portal" do
  before(:each) do
    sign_in
  end

  describe "Notification" do
    it "displays expired passports count" do
      p = create(:person)
      p.identifications.create(foid_type: "Passport", foid: "PP-EXPIRED-01", expiration_date: Date.today.to_date)
      visit portal_index_path
      expect(page).to have_link("There are 1 Passports that are within 7 months of expiry")
    end

     it "does not count not-expired passports" do
      Profile.destroy_all
      p = create(:person)
      p.identifications.create(foid_type: "Passport", foid: "PP-FUTURE-PROOF-01", expiration_date: Date.today.to_date + 211)
      visit portal_index_path
      expect(page).to have_no_content("PP-FUTURE-PROOF-01")
      within "div.notifications" do
        expect(page).to have_content("none")
      end
    end

  end
end