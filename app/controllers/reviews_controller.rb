class ReviewsController < ApplicationController
  before_action :logged_in_user
  before_action :find_review_book, only: [:edit, :update, :destroy]

  def create
    review = current_user.reviews.new review_params
    book = Book.find_by_id params[:book_id]
    check_null book
    review.book_id = book.id
    if review.save
      flash[:success] = t "reviews.success"
    else
      flash[:danger] = t "reviews.danger"
    end
    redirect_to :back
  end

  def destroy
    if @review.destroy
      flash[:success] = t "reviews.success"
    else
      flash[:danger] = t "reviews.danger"
    end
    redirect_to @book
  end

  def edit
    respond_to do |format|
      format.html {redirect_to @book}
      format.js
    end
  end

  def update
    if @review.update_attributes review_params
      flash[:success] = t "reviews.success"
      @review_new = @book.reviews.new
      @comment_new = Comment.new
      @rated = @book.average_rate
      respond_to do |format|
        format.html {redirect_to @book}
        format.js
      end
    else
      flash[:danger] = t "reviews.danger"
      render :edit
    end
  end

  private
  def review_params
    params.require(:review).permit :content, :rated
  end

  def find_review_book
    @review = Review.find_by_id params[:id]
    check_null @review
    @book = @review.book
    check_null @book
  end
end
