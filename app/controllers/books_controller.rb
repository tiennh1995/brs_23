class BooksController < ApplicationController
  before_action :logged_in_user
  before_action :check_admin, only: :index

  def index
    @types = Book.column_search.map {|e| I18n.t("books.column.#{e}")}
    @books = Book.search(params[:search], params[:type]).paginate page:
      params[:page], per_page: Settings.per_page
  end

  def show
    @book = Book.find_by_id params[:id]
    check_null @book
    @favorite_num = @book.marks.loved.size
    @reviews = @book.reviews.paginate page: params[:page],
      per_page: Settings.per_page
    @review_new = @reviews.build
    @mark = @book.marks.find_by user_id: current_user.id
    if @mark.nil?
      @mark = @book.marks.create user_id: current_user.id, read: :reading
    end
    @comment_new = Comment.new
  end
end
