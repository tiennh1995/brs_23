class UsersController < ApplicationController
  before_action :logged_in_user, except: [:new, :create]
  before_action :find_user, only: [:edit, :show, :update]
  before_action :correct_user, only: [:edit, :update]
  before_action :check_admin, except: [:new, :create, :show]

  def index
    @users = User.all
  end

  def show
    redirect_to root_url if @user.is_admin?
    @activities = @user.activity.order_by_time.paginate page:
      params[:page], per_page: Settings.per_page_activity
    @list_books = Activity.list_book @activities
    @list_users = Activity.list_user @activities
    @like = Like.new
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

  def edit
  end

  def update
    if @user.update_attributes user_params
      flash[:success] = t "action.success"
      redirect_to :back
    else
      render :edit
    end
  end

  private
  def user_params
    params.require(:user).permit :fullname, :email, :password,
      :password_confirmation, :avatar
  end

  def find_user
    @user = User.find_by_id params[:id]
    check_null @user
  end

  def correct_user
    redirect_to root_url unless current_user? @user
  end
end
