class DocImageController < ApplicationController
  def new
    get_identification
  end

  def download
    @identification = get_identification

    path = if params[:version] == :original
      "#{Rails.root}/#{@identification.doc_image.url(params[:version])}"
    else
      "#{Rails.root}/#{@identification.doc_image.url()}"
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
  end
end
