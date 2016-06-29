class StaticPagesController < ApplicationController
  before_action :logged_in_user, only: :home
  def home
    @books = Book.paginate page: params[:page], per_page: Settings.per_page
    @activities = current_user.activity.order_by_time.paginate page:
      params[:page], per_page: Settings.per_page_activity
    @list_books = Activity.list_book @activities
    @list_users = Activity.list_user @activities
    @like = Like.new
  end

  def help
  end

  def about
  end
end
