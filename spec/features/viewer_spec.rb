require 'spec_helper'

describe "Viewer" do

  describe "Profile Index", :js do
    before(:each) do
      sign_in_as role: :viewer
    end

    it "can view the data table" do
      person = create(:person)
      company = create(:company)
      vendor = create(:vendor)

      visit profiles_path
      expect(page).to have_content(person.full_name)

      select 'CORPORATE'
      expect(page).to have_content(company.full_name)

      select 'VENDOR'
      expect(page).to have_content(vendor.full_name)
    end

    it "can access expiring passport page" do
      visit expiring_passports_path
      expect(page).to have_content('expiring passports')
    end
  end
end