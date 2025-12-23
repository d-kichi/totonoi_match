class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :store_user_location!, if: :storable_location?

  protected

  def after_sign_in_path_for(resource)
    stored_location_for(resource) || super
  end

  def after_sign_up_path_for(resource)
    stored_location_for(resource) || super
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:username])
    devise_parameter_sanitizer.permit(:account_update, keys: [:username])
  end

  private

  # ログイン/登録後に戻したいURLを保存
  def store_user_location!
    target = params[:redirect_to].presence || request.fullpath
    store_location_for(:user, target)
  end

  def storable_location?
    request.get? &&
      is_navigational_format? &&
      !devise_controller? &&
      !request.xhr? &&
      !request.fullpath.start_with?("/users/auth")
  end
end
