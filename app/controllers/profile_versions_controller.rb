class ProfileVersionsController < ApplicationController
  load_and_authorize_resource :class => "PaperTrail::Version"
  
  def index

  	if params[:profile_id]
 		  @versions = PaperTrail::Version.where(profile_id: params[:profile_id]).order("created_at desc")

  	else
  		@versions = PaperTrail::Version.all.includes(:profile, :user).order("created_at desc")
  	end

  	@versions = @versions.paginate(:page => params[:page]).per_page(20)

  	respond_to do | format |
  		format.html
  		format.js
  	end

  end
end
