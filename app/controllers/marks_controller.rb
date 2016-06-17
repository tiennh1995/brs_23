class MarksController < ApplicationController
  before_action :logged_in_user
  before_action :correct_user, only: :index
  before_action :find_book, only: [:create, :destroy]
  def index
    @marks = current_user.marks
  end

  def create
    if @mark.save
      respond_to do |format|
        format.html {redirect_to @book}
        format.js
      end
    else
      flash[:danger] = t "error.fail"
    end
  end

  def destroy
    favorite = @book.marks.find_by id: params[:id], is_favorite: true
    if favorite.present?
      favorite.destroy
      respond_to do |format|
        format.html {redirect_to @book}
        format.js
      end
    else
      flash[:danger] = t "error.fail"
    end
  end

  private
  def correct_user
    user = User.find_by_id params[:user_id]
    redirect_to root_url unless current_user? user
  end

  def find_book
    @book = Book.find params[:book_id]
    unless @mark
      @mark = current_user.marks.build book_id: @book.id, is_favorite: true
    end
  end
end
