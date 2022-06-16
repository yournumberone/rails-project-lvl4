# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include Authentication
  include Pundit::Authorization

  helper_method :current_user, :signed_in?

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  def user_not_authorized
    flash[:alert] = t('permission_denied')
    redirect_back(fallback_location: root_path)
  end
end
