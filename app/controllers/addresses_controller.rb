class AddressesController < ApplicationController
  before_action :set_address, only: [:show, :edit, :update, :destroy]

  # GET /addresses
  # GET /addresses.json
  def index
    @addresses = Address.all
  end

  # GET /addresses/1
  # GET /addresses/1.json
  def show
  end

  # GET /addresses/new
  def new
    @address = Address.new(owner_type: 'Profile', owner_id: params[:profile_id])
    @source = params[:source]
  end

  # GET /addresses/1/edit
  def edit
    respond_to do |format|
      format.html
      format.js
    end
  end

  # POST /addresses
  # POST /addresses.json
  def create
    @address = Address.new(address_params)
    respond_to do |format|
      if @address.save
        @profile = @address.owner
        format.html { redirect_to @address, notice: 'Address was successfully created.' }
        format.json { render action: 'show', status: :created, location: @address }
        format.js { reload }
      else
        format.html { render action: 'new' }
        format.json { render json: @address.errors, status: :unprocessable_entity }
        format.js { render 'error'}
      end
    end
  end

  # PATCH/PUT /addresses/1
  # PATCH/PUT /addresses/1.json
  def update
    respond_to do |format|
      if @address.update(address_params)
        format.html { redirect_to @address, notice: 'Address was successfully updated.' }
        format.json { head :no_content }
        format.js { reload }
      else
        format.html { render action: 'edit' }
        format.json { render json: @address.errors, status: :unprocessable_entity }
      end
    end
  end

  def reload
    respond_to do |format|
      format.js do
        if params[:source] == 'index'
          render 'profiles/update_profile_row'
        else
          render 'reload_table'
        end
      end
    end
  end

  # DELETE /addresses/1
  # DELETE /addresses/1.json
  def destroy
    @address.destroy
    respond_to do |format|
      format.html { redirect_to addresses_url }
      format.json { head :no_content }
      format.js
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_address
      @address = Address.find(params[:id])
      @profile = @address.try :owner
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def address_params
      params.require(:address).permit(:owner_id, :owner_type, :line_one, :line_two, :city, :state_region, :zipcode, :country, :address_type)
    end
end
