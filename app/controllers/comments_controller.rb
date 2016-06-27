class CommentsController < ApplicationController
  before_action :logged_in_user
  before_action :correct_user
  before_action :find_comment, only: [:destroy, :edit, :update]

  def create
    @comment = current_user.comments.new comment_params
    @review = Review.find_by_id params[:review_id]
    check_null @review
    @comment.review_id = @review.id
    if @comment.save
      respond_to do |format|
        format.html {redirect_to @review.book}
        format.js
      end
    else
      flash[:danger] = t "comments.danger"
      redirect_to :back
    end
  end

  def destroy
    @comment.destroy
    respond_to do |format|
      format.html {redirect_to @book}
      format.js
    end
  end

  def edit
    respond_to do |format|
      format.html {redirect_to @book}
      format.js
    end
  end

  def update
    if @comment.update_attributes comment_params
      flash.now[:success] = t "comments.success"
      @comment_new = Comment.new
      respond_to do |format|
        format.html {redirect_to @book}
        format.js
      end
    else
      flash[:danger] = t "comments.danger"
      render :edit
    end
  end

  private
  def comment_params
    params.require(:comment).permit :content
  end

  def find_comment
    @comment = Comment.find_by_id params[:id]
    check_null @comment
    @review = @comment.review
    check_null @review
    @book = @review.book
    check_null @book
  end

  def correct_user
    review = Review.find_by_id params[:review_id]
    review ? current_user?(review.user) : redirect_to(root_path)
  end
end
