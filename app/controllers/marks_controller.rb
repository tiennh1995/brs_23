class MarksController < ApplicationController
  before_action :logged_in_user
  before_action :correct_user, only: :index
  before_action :find_mark, only: :update
  def index
    @marks = current_user.marks.read_or_reading
    @favorites = current_user.marks.loved
  end

  def update
    if params[:mark].present?
      params[:mark] == "favorite" ?
        @mark.update_attributes(is_favorite: false) : @mark.nothing!
      redirect_to :back
    elsif params[:read].present? || params[:is_favorite].present?
      @book = Book.find params[:book_id]
      check_null @book
      params[:read].present? ? @mark.update_attributes(read: :read) :
        @mark.update_attributes(is_favorite: params[:is_favorite])
      respond_to do |format|
        format.html {redirect_to book_path(@book, @mark)}
        format.js
      end
    end
  end

  private
  def correct_user
    user = User.find_by_id params[:user_id]
    redirect_to root_url unless current_user? user
  end

  def find_mark
    @mark = Mark.find params[:id]
    check_null @mark
  end
end
