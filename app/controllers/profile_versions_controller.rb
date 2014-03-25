class ProfileVersionsController < ApplicationController
  def index
  	@versions = PaperTrail::Version.all
  end
end
