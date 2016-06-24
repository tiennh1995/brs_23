class BooksController < ApplicationController
  before_action :logged_in_user
  def index
    @books = Book.search(params[:search]).paginate page: params[:page],
      per_page: Settings.per_page
    @rateds = Book.average_rates
  end

  def show
    @book = Book.find_by_id params[:id]
    check_null @book
    @mark = @book.marks.find_or_initialize_by user_id: current_user.id,
      is_favorite: true
    @reviews = @book.reviews.paginate page: params[:page],
      per_page: Settings.per_page
    @review = @reviews.build
    @rated = @book.average_rate
  end
end
