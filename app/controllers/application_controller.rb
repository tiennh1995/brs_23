class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper

  private
  def logged_in_user
    unless logged_in?
      store_location
      flash.now[:danger] = t "users.logged_in_user.danger"
      redirect_to login_url
    end
  end

  def admin_user
    redirect_to root_url unless current_user.is_admin?
  end

  def check_admin
    redirect_to admin_root_url if current_user.is_admin?
  end

  def check_null object
    unless object
      flash[:danger] = t "error.fail"
      redirect_to root_url
    end
  end
end
