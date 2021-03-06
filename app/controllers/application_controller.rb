class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_filter :authenticate_user!
  before_filter :configure_permitted_parameters, if: :devise_controller?

  load_and_authorize_resource :unless => :excluded_controllers

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, :alert => exception.message
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:username, :email, :password, :password_confirmation, :remember_me) }
    devise_parameter_sanitizer.for(:sign_in) { |u| u.permit(:login, :username, :email, :password, :remember_me) }
    devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:username, :email, :password, :password_confirmation, :current_password) }
  end

  def check_if_user_is_admin
    unless current_user.try :admin?
      flash[:error] = "You are not authorized to do that action"
      render "layouts/error"
    end
  end

  before_filter :miniprofiler
  
  private
  def miniprofiler
    Rack::MiniProfiler.authorize_request if current_user && current_user.username == "jchan"
  end

  def excluded_controllers
     (params[:controller] == 'doc_image' || 
      params[:controller] == "profile_versions" || 
      params[:controller] == "portal" || devise_controller?)
  end

end
