class Admin::BooksController < ApplicationController
  before_action :logged_in_user
  before_action :admin_user

  def index
    @books = Book.paginate page: params[:page], per_page: Settings.per_page
  end

  def new
    @book = Book.new
    @categories = Category.all
  end

  def create
    @book = Book.new book_params
    if @book.save
      redirect_to root_path
    else
      @categories = Category.all
      render :new
    end
  end

  private
  def book_params
    params.require(:book).permit :title, :publish_date, :author,
      :pages, :picture, :category_id
  end
end
