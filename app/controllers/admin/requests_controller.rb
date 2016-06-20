class Admin::RequestsController < ApplicationController
  before_action :logged_in_user
  before_action :admin_user

  def index
    @requests = Request.all
  end

  def show
    @users = User.all
  end

  def destroy
    request = Request.find_by_id params[:id]
    if request.present?
      request.destroy
      flash.now[:success] = t "activerecord.controllers.request.destroy.success"
    else
      flash.now[:danger] = t "activerecord.controllers.request.destroy.danger"
    end
    redirect_to admin_requests_path
  end
end
