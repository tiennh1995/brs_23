class Admin::BooksController < ApplicationController
  before_action :logged_in_user
  before_action :admin_user
  before_action :find_book, only: [:edit, :update, :destroy]

  def index
    @books = Book.paginate page: params[:page], per_page: Settings.per_page
    @categories = Category.all
  end

  def new
    @book = Book.new
    @categories = Category.all
  end

  def create
    @book = Book.new book_params
    if @book.save
      redirect_to admin_books_path
    else
      @categories = Category.all
      render :new
    end
  end

  def edit
    @categories = Category.all
  end

  def update
    if @book.update_attributes book_params
      flash[:success] = t "activerecord.controllers.admin.update.success"
      redirect_to admin_books_path
    else
      @categories = Category.all
      render :edit
    end
  end

  def destroy
    if @book.destroy
      flash[:success] = t "activerecord.controllers.admin.destroy.success"
    else
      flash[:danger] = t "activerecord.controllers.admin.destroy.danger"
    end
    redirect_to :back
  end

  private
  def book_params
    params.require(:book).permit :title, :publish_date, :author,
      :pages, :picture, :category_id
  end
  def find_book
    @book = Book.find params[:id]
  end
end
