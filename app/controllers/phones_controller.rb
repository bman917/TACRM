class PhonesController < ApplicationController
  before_action :set_phone, only: [:show, :edit, :update, :destroy]

  # GET /phones
  # GET /phones.json
  def index
    @phones = Phone.all
  end

  # GET /phones/1
  # GET /phones/1.json
  def show
  end

  # GET /phones/new
  def new
    @phone = Phone.new(contact_detail_type: 'Profile', contact_detail_id: params[:profile_id])
    @source = params[:source]
  end

  # GET /phones/1/edit
  def edit
    respond_to do |format|
      format.html
      format.js
    end
  end

  # POST /phones
  # POST /phones.json
  def create
    @phone = Phone.new(phone_params)
    respond_to do |format|
      if @phone.save

        @profile = @phone.contact_detail
        format.html { redirect_to profiles_path, notice: 'Phone was successfully created.' }
        format.json { render action: 'show', status: :created, location: @phone }
        format.js { reload}
      else
        format.html { render action: 'new' }
        format.json { render json: @phone.errors, status: :unprocessable_entity }
        format.js { render 'error'}
      end
    end
  end

  # PATCH/PUT /phones/1
  # PATCH/PUT /phones/1.json
  def update
    respond_to do |format|
      if @phone.update(phone_params)
        format.html { redirect_to @phone, notice: 'Phone was successfully updated.' }
        format.json { head :no_content }
        format.js { reload }
      else
        format.html { render action: 'edit' }
        format.json { render json: @phone.errors, status: :unprocessable_entity }
      end
    end
  end

  def reload
    respond_to do |format|
      format.js do
        if params[:source] == 'index'
          render 'update'
        else
          render 'reload_table'
        end
      end
    end
  end

  # DELETE /phones/1
  # DELETE /phones/1.json
  def destroy
    @phone.destroy
    respond_to do |format|
      format.html { redirect_to phones_url }
      format.json { head :no_content }
      format.js
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_phone
      @phone = Phone.find(params[:id])
      @profile = @phone.try :contact_detail
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def phone_params
      params.require(:phone).permit(:phone_type, :number, :description, :contact_detail_id, :contact_detail_type)
    end
end
