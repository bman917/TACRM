class IdentificationsController < ApplicationController
  before_action :set_identification, only: [:show, :edit, :update, :destroy]

  def expiring
    @expiring_passports = Identification.passports.where("expiration_date < ?", Date.today.to_date + 210)
  end

  # GET /identifications
  # GET /identifications.json
  def index
    @identifications = Identification.all

  end

  # GET /identifications/1
  # GET /identifications/1.json
  def show
  end

  # GET /identifications/new
  def new
    @identification = Identification.new
    @identification.visa_type = "TOURIST"
    @identification.profile_id = params[:profile_id]

    respond_to do | format |
      format.html
      format.js { render 'remote_form'}
    end
  end

  # GET /identifications/1/edit
  def edit
    @identification.country = @identification.try(:country).try(:titleize)

    respond_to do | format |
      format.html
      format.js { render 'remote_form'}
    end

  end

  # POST /identifications
  # POST /identifications.json
  def create
    @identification = Identification.new(identification_params)
    @profile = @identification.try :profile

    respond_to do |format|
      if @identification.save

        notice = "#{@identification.foid_type} for #{@identification.profile.full_name} was successfully created."
        format.html { redirect_to identifications_path, flash: {identification_notice: notice}}
        format.json { render action: 'show', status: :created, location: @identification }
        # format.js { render "add_#{@identification.foid_type.try :downcase}" }
        format.js { render 'add_identification'}
      else
        format.html { render action: 'new' }
        format.json { render json: @identification.errors, status: :unprocessable_entity }
        format.js
      end
    end
  end

  # PATCH/PUT /identifications/1
  # PATCH/PUT /identifications/1.json
  def update
    respond_to do |format|
      if @identification.update(identification_params)
        notice = "#{@identification.foid_type} for #{@identification.profile.full_name} was successfully updated."
        format.html { redirect_to identifications_path,  flash: {identification_notice: notice}}
        format.json { head :no_content }
        format.js { render 'add_identification'}
      else
        format.html { render action: 'edit' }
        format.json { render json: @identification.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /identifications/1
  # DELETE /identifications/1.json
  def destroy
    @identification.destroy
    respond_to do |format|
      format.html { redirect_to identifications_url }
      format.json { head :no_content }
      format.js { render "delete_by_type" }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_identification
      @identification = Identification.find(params[:id])
      @profile = @identification.try :profile
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def identification_params
      params.require(:identification).permit(:foid_type, :foid, :notes, 
        :profile_id, :date_issued, :expiration_date, :issued_by, :description,
        :country, :sub_type, :visa_type, :entry_date, :max_stay)
    end
end
