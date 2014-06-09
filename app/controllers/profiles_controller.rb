class ProfilesController < ApplicationController
  before_action :set_profile, only: [:show, :edit, :update, :destroy, :lock, :unlock]
  # before_action :check_if_user_is_admin, only: [:new, :edit, :update, :destroy, :create]

  def lock_all
    Profile.update_all(locked: true)
    flash[:notice] = "All Profiles Locked!!"
    Rails.cache.clear
    redirect_to action: :index
  end

  def unlock_all
    Profile.update_all(locked: false)
    flash[:notice] = "All Profiles UnLocked!!"
    Rails.cache.clear
    redirect_to action: :index
  end
  
  def lock
    do_lock(true)
  end

  def unlock
    do_lock(false)
  end

  def full_names
    @profiles = Profile.search_by_name(params[:term])
    render json: @profiles.to_json(methods: :label) 
  end

  def search
    @profiles = Profile.order(:name).where("name like ?", "%#{params[:term]}%")
  end

  # GET /profiles
  # GET /profiles.json
  def index
    index_load
    # # @profiles = Profile.all
    @profile = Profile.new(profile_type: 'INDIVIDUAL')

    respond_to do | format |
      format.html
      format.js
    end
  end

  def corporate_index
    @profiles = Profile.where(profile_type: 'CORPORATE')
    @profile = Profile.new(profile_type: 'CORPORATE')
  end

  # GET /profiles/1
  # GET /profiles/1.json
  def show
    @new_phone = Phone.new(contact_detail_type: @profile.class, contact_detail_id: @profile.id)
    @new_address = Address.new(owner_type: @profile.class, owner_id: @profile.id)
    @group = Group.new(account: @profile.account)
    @account = Account.new(profile: @profile, name: @profile.full_name)
    @note = Note.new(profile: @profile)
    @identification = Identification.new(profile: @profile)

    # @versions = PaperTrail::Version.where(profile_id: @profile).paginate(:page => params[:page]).per_page(10).order("created_at desc")
    @versions = @profile.profile_versions.includes(:user).paginate(:page => params[:page]).per_page(10).order("created_at desc")
    
    @liquid_slider_panel = params[:panel_number] || if params[:page] 
      @liquid_slider_panel = @profile.updates_liquid_slider_panel_number 
    else
      @liquid_slider_panel = 1
    end

  end

  # GET /profiles/new
  def new
    @profile = Profile.new
    # @profile.client_since = Date.today
    @profile.profile_type = params[:profile_type] || 'INDIVIDUAL'
    # render 'new2'
  end

  # GET /profiles/1/edit
  def edit
  end

  # POST /profiles
  # POST /profiles.json
  def create
    @profile = Profile.new(profile_params)
    @profile.status = 'ACTIVE'

    # puts "FullName: #{@profile.full_name}"
    # puts "Individual Client: #{@profile.individual_client?}"

    if @profile.individual_client? ||  @profile.corporate_client?
      @profile.account = Account.new(name: @profile.full_name)
       # puts "Creating Account for #{@profile.full_name}. Accont name: [#{@profile.account.name}]"
    end

    respond_to do |format|
      if @profile.save
        format.html { redirect_to @profile, notice: 'Profile was successfully created.' }
        format.json { render action: 'show', status: :created, location: @profile }
      else
        index_load
        format.html { render 'index' }
        format.json { render json: @profile.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /profiles/1
  # PATCH/PUT /profiles/1.json
  def update
    respond_to do |format|
      if @profile.update(profile_params)
          format.html { redirect_to @profile, notice: 'Profile was successfully updated.' }
          format.js { index_load }
          format.json { render json: @profile }
      else
        format.html { render action: 'edit' }
        format.json { render json: @profile.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /profiles/1
  # DELETE /profiles/1.json
  def destroy
    if @profile.locked?
      redirect_to profiles_url,  notice: "#{@profile.full_name} cannot be deleted because it is LOCKED."
    else
      @profile.destroy
      respond_to do |format|
        format.html { redirect_to profiles_url, notice: "Deleted #{@profile.full_name}" }
        format.json { head :no_content }
      end
    end
  end

  private
    def do_lock(status)
      @profile.locked = status
      @profile.save!

      respond_to do |format|

        format.html do 
          flash[:notice] = "Profile of '#{@profile.full_name}' is now '#{@profile.lock_status}'"
          if params[:render] && params[:render] == 'show'
            redirect_to action: :show
          else
            redirect_to action: :index
          end
        end

        format.js { render 'lock' }

      end


    end

    def index_load
      @profile_type = params[:profile_type] || 'ALL'
      @profile_type.upcase!

      case @profile_type
      when 'ALL'
        @profiles = Profile.all
      when 'NO_CONACT_DETAILS'
        @profiles = Profile.no_contact_detail
      when 'NO_ADDRESS'
        @profiles = Profile.no_address
      else
        @profiles = Profile.where(profile_type: @profile_type)
      end
    end
    # Use callbacks to share common setup or constraints between actions.
    def set_profile
      @profile = Profile.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def profile_params
      params.require(:profile).permit(:contact_person, :business_type,
        :client_since,:credit_limit,:terms,:status,:lead_source,:nationality, 
        :name, :profile_type, :first_name, :last_name, :middle_name, :birth_day, 
        :gender, :email, :marital_status, :occupation, :employer, :job_position)
    end
end
