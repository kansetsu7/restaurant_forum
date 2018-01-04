class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception #before action must put below
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?

  private 
  def authenticate_admin
    unless current_user.admin?
      flash[:alert] = 'Not allow!'
      redirect_to root_path
    end
  end

  protected

  def configure_permitted_parameters
    return until (params[:controller] == "devise/registrations" && (params[:action] == "create" || params[:action] == "update"))

    # if user didn't specify their name, set email name as default
    if params[:user][:name] == ""
      params[:user][:name] = params[:user][:email].split('@').first
    end

    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name])
  end

end
