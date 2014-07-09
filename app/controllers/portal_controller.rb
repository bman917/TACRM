class PortalController < ApplicationController
  def index
    @expiring_passports = Identification.passports.where("expiration_date < ?", Date.today.to_date + 30)

  end
end
