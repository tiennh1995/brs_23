class MarksController < ApplicationController
  before_action :logged_in_user
  before_action :correct_user, only: :index
  before_action :find_book, only: :create
  def index
    @marks = current_user.marks.read_or_reading
    @favorites = current_user.marks.where is_favorite: true
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

  def update
    @mark = Mark.find_by id: params[:id]
    check_null @mark
    if params[:mark] == "favorite"
      @mark.update_attributes is_favorite: false
    else
      @mark.nothing!
    end
    redirect_to :back
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
