class DocImageController < ApplicationController
  before_action :get_identification

  def new
    get_identification
  end

  def upload
    if @identification.update(identification_params)
      render 'identifications/add_identification'
    else
      render 'error'
    end
  end

  def download
    @identification = get_identification

    path = if params[:version] == "original"
      "#{DocImageUploader.root}/#{@identification.doc_image.url()}"
    else
      "#{DocImageUploader.root}/#{@identification.doc_image.url(params[:version])}"
    end

    send_file path, :x_sendfiel=>true
  end

  def destroy
    @identification = get_identification
    @identification.remove_doc_image!
    @identification.save
    redirect_to profile_path(@identification.profile)
  end

  def view
    get_identification
  end

  private
    def get_identification
      @identification = Identification.find(params[:id])
      @profile = @identification.profile
      return @identification
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def identification_params
      params.require(:identification).permit(:doc_image)
    end    
end
