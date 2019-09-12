# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected
    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :email, :password, :password_confirmation, :image, :image_cache])
      devise_parameter_sanitizer.permit(:account_update, keys: [:name, :email, :password, :password_confirmation, :image, :image_cache, :remove_image])
    end
end
