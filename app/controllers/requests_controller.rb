class RequestsController < ApplicationController
  before_action :logged_in_user, only: [:new, :create]
  before_action :check_admin, only: [:new, :create]

  def new
    @request = Request.new
    @user = current_user
  end

  def create
    @request = current_user.requests.new request_params
    if @request.save
      redirect_to root_url
      flash[:success] = t "activerecord.controllers.request.create.success"
    else
      render :new
    end
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
