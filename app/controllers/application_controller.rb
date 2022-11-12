class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_notifications, if: :current_user
  
    protected

    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: [:username])
      devise_parameter_sanitizer.permit(:account_update, keys: [:username])
    end

    private

    def set_notifications
      @unread_notifications = current_user.invitations.unconfirmed.limit(10).order(created_at: :desc)
    end
end
