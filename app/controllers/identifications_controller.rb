class IdentificationsController < ApplicationController
  before_action :set_identification, only: [:show, :edit, :update, :destroy]

  # GET /identifications
  # GET /identifications.json
  def index
    @identifications = Identification.all
    @identification = Identification.new
  end

  # GET /identifications/1
  # GET /identifications/1.json
  def show
  end

  # GET /identifications/new
  def new
    @identification = Identification.new
  end

  # GET /identifications/1/edit
  def edit
  end

  # POST /identifications
  # POST /identifications.json
  def create
    @identification = Identification.new(identification_params)

    respond_to do |format|
      if @identification.save
        format.html { redirect_to @identification, notice: 'Identification was successfully created.' }
        format.json { render action: 'show', status: :created, location: @identification }
        format.js { render "add_#{@identification.foid_type.try :downcase}" }
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
        format.html { redirect_to @identification, notice: 'Identification was successfully updated.' }
        format.json { head :no_content }
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
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def identification_params
      params.require(:identification).permit(:foid_type, :foid, :notes, 
        :profile_id, :date_issued, :expiration_date, :issued_by,
        :country, :sub_type, :visa_type, :entry_date, :max_stay )
    end
end
