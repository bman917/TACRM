require 'spec_helper'

describe "Portal" do
  before(:each) do
    sign_in
  end

  describe "Passports Notification" do
    it "displays expired passports" do
      p = create(:person)
      p.identifications.create(foid_type: "Passport", foid: "PP-EXPIRED-01", expiration_date: Date.today.to_date)
      visit portal_index_path
      expect(page).to have_content("PP-EXPIRED-01")
    end

     it "does not display not-expired passports" do
      Profile.destroy_all
      p = create(:person)
      p.identifications.create(foid_type: "Passport", foid: "PP-FUTURE-PROOF-01", expiration_date: Date.today.to_date + 31)
      visit portal_index_path
      expect(page).to have_no_content("PP-FUTURE-PROOF-01")
      expect(page).to have_content("none")
    end

  end
end