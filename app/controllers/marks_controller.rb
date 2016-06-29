class MarksController < ApplicationController
  before_action :logged_in_user
  before_action :correct_user, only: :index
  def index
    @marks = current_user.marks.read_or_reading
    @favorites = current_user.marks.loved
  end

  def update
    @mark = Mark.find_by_id params[:id]
    check_null @mark
    if params[:mark] == "favorite"
      @mark.update_attributes is_favorite: false
      redirect_to :back
    elsif params[:mark] == "read"
      @mark.nothing!
      redirect_to :back
    else
      @book = Book.find_by_id params[:book_id]
      check_null @book
      @mark.update_attributes mark_params
      if params[:mark][:is_favorite]
        current_user.activities.find_or_create_by action_id: @book.id,
          activity_type: 2
      elsif params[:mark][:read] == "read"
        current_user.activities.find_or_create_by action_id: @book.id,
          activity_type: 1
      end
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
  def mark_params
    params.require(:mark).permit :is_favorite, :read
  end
end
