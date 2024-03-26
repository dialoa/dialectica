class ApplicationController < ActionController::Base
  include Pundit

  before_action :configure_permitted_parameters, if: :devise_controller?
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  protected

  def configure_permitted_parameters
    added_attrs = [:username, :email, :password, :password_confirmation, :remember_me, :firstname, :lastname, :notify_me_when_i_am_suggested_as_an_internal_referee, :notify_me_when_something_happens_to_my_fish]
    devise_parameter_sanitizer.permit(:sign_up, keys: added_attrs)
    devise_parameter_sanitizer.permit(:account_update, keys: added_attrs)
  end

  private

  def user_not_authorized
    flash[:alert] = "you are not authorized to perform this action."
    redirect_to(request.referrer || root_path)
  end


end
