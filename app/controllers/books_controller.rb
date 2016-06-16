class BooksController < ApplicationController
  def index
    @books = Book.paginate page: params[:page], per_page: Settings.per_page
  end

  def show
    @book = Book.find params[:id]
  end
end
