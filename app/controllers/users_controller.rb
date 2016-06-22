class UsersController < ApplicationController
  before_action :logged_in_user, only: [:index, :show]

  def index
    @users = User.all
  end

  def show
    @user = User.find_by_id params[:id]
    check_null @user
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params
    if @user.save
       log_in @user
       redirect_to root_url
       flash.now[:success] = t "activerecord.controllers.users.success"
    else
      render :new
    end
  end

  private
  def user_params
    params.require(:user).permit :fullname, :email, :password,
      :password_confirmation
  end
end
