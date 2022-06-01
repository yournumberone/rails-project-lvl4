# frozen_string_literal: true

module Authentication
  def sign_in(user)
    session[:user_id] = user.id
  end

  def sign_out
    session.delete(:user_id)
    session.clear
  end

  def signed_in?
    !current_user.nil?
  end

  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  def authenticate_user!
    return if signed_in?

    redirect_to(sign_in_path, notice: t('introduce_yourself_cowboy'))
  end

  def authenticate_admin!
    authorize :admin, :admin?
  end
end
