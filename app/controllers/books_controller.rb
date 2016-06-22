class BooksController < ApplicationController
  before_action :logged_in_user
  def index
    @books = Book.paginate page: params[:page], per_page: Settings.per_page
  end

  def show
    @book = Book.find_by_id params[:id]
    unless @book
      flash[:danger] = t "error.fail"
      redirect_to root_url
    end
    @mark = @book.marks.find_or_initialize_by user_id: current_user.id,
      is_favorite: true
  end
end
