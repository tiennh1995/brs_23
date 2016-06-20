class RequestsController < ApplicationController
  before_action :logged_in_user, except: [:show, :edit, :update]
  before_action :check_admin, only: [:new, :create]

  def index
    @requests = current_user.requests
  end

  def new
    @request = Request.new
  end

  def create
    @request = current_user.requests.new request_params
    if @request.save
      redirect_to user_requests_path
      flash.now[:success] = t "activerecord.controllers.request.create.success"
    else
      render :new
    end
  end

  def destroy
    request = Request.find_by_id params[:id]
    if request.present?
      request.destroy
      flash[:success] = t "activerecord.controllers.request.destroy.success"
    else
      flash[:danger] = t "activerecord.controllers.request.destroy.danger"
    end
    redirect_to user_requests_path
  end

  private
  def request_params
    params.require(:request).permit :book_title, :book_publish_date,
      :book_author
  end

  def check_admin
    redirect_to admin_root_url if current_user.is_admin?
  end
end
