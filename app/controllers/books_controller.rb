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
    @favorite_num = @book.marks.loved.size
    @reviews = @book.reviews.paginate page: params[:page],
      per_page: Settings.per_page
    @review_new = @reviews.build
    @rated = @book.average_rate
    @mark = @book.marks.find_by user_id: current_user.id
    if @mark.nil?
      @mark = @book.marks.create user_id: current_user.id, read: :reading
    end
    @comment_new = Comment.new
  end
end
