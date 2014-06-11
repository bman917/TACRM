class MembersController < ApplicationController
  before_action :set_member, only: [:show, :edit, :update, :destroy]

  # GET /members
  # GET /members.json
  def index
    @members = Member.all
  end

  # GET /members/1
  # GET /members/1.json
  def show
  end

  # GET /members/new
  def new
    @profile = Profile.find(params[:profile_id])
    @member = @profile.default_group.members.build
  end

  # GET /addresses/1/edit
  def edit
    respond_to do |format|
      format.html
      format.js
    end
  end

  # POST /members
  # POST /members.json
  def create
    @member = Member.new(member_params)

    respond_to do |format|
      if @member.save
         @profile = @member.owner
        format.html { redirect_to @member.group.profile, notice: 'Member was successfully created.' }
        format.json { render action: 'show', status: :created, location: @member }
        format.js { reload }
      else
        format.html { render action: 'new' }
        format.json { render json: @member.errors, status: :unprocessable_entity }
        format.js
      end
    end
  end

  # PATCH/PUT /members/1
  # PATCH/PUT /members/1.json
  def update
    respond_to do |format|
      if @member.update(member_params)
        format.html { redirect_to @member, notice: 'Member was successfully updated.' }
        format.json { head :no_content }
        format.js { reload }
      else
        format.html { render action: 'edit' }
        format.json { render json: @member.errors, status: :unprocessable_entity }
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



  # DELETE /members/1
  # DELETE /members/1.json
  def destroy
    @member.destroy
    respond_to do |format|
      format.html { redirect_to @member.group.profile }
      format.json { head :no_content }
      format.js
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_member
      @member = Member.find(params[:id])
      @profile = @member.owner
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def member_params
      params.require(:member).permit(:profile_id, :group_id, :relationship)
    end
end
