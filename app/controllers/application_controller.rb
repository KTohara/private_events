class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_notifications, if: :current_user
  
    protected

    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: [:username])
      devise_parameter_sanitizer.permit(:account_update, keys: [:username])
    end

    def set_notifications
      @unread_notifications = current_user.invitations.unconfirmed.limit(10).order(created_at: :desc)
    end

    def authenticate_host
      params_id = controller_name == 'events' ? params[:id] : params[:event_id]
      event_host = Event.find(params_id).host
      unless current_user == event_host
        redirect_back_or_to root_path, notice: "These aren't the invitations you're looking for..."
      end
    end
end
