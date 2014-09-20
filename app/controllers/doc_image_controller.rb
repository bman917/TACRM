class DocImageController < ApplicationController
  def new
    @identification = Identification.find(params[:id])
  end

  def create
  end

  def edit
  end

  def destroy
  end
end
