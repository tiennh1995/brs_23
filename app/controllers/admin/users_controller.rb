class Admin::UsersController < ApplicationController
  before_action :logged_in_user, only: [:index, :destroy]
  before_action :admin_user, only: [:index, :destroy]

  def index
    @users = User.all
  end

  def destroy
    user = User.find_by_id params[:id]
    if user.present?
      user.destroy
      flash.now[:success] = t "activerecord.controllers.admin.destroy.success"
    else
      flash.now[:danger] = t "activerecord.controllers.admin.destroy.danger"
    end
    redirect_to admin_users_url
  end
end
