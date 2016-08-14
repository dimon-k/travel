class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  # New columns "Name" and "Lastname" adding to Devise configuration:
  before_action :configure_devise_permitted_parameters, if: :devise_controller?

  protected

  def configure_devise_permitted_parameters
    registration_params = [:name, :lastname, :email, :password, :password_confirmation]

    if params[:action] == 'update'
      devise_parameter_sanitizer.for(:account_update) {
        |u| u.permit(registration_params << :current_password)
      }
    elsif params[:action] == 'create'
      devise_parameter_sanitizer.for(:sign_up) {
        |u| u.permit(registration_params)
      }
    end
  end

  # Checking whether the current_user is an Author of the Post of Comment or an Admin
  def user_or_admin
    if @comment != nil
      redirect_to @post unless current_user.id == @comment.user_id || current_user.admin?
    elsif @post != nil
      redirect_to @post unless current_user.id == @post.user_id || current_user.admin?
    else
      redirect_to root_path unless current_user.admin? if user_signed_in?
    end
  end

end
