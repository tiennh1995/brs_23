class ReviewsController < ApplicationController
  before_action :logged_in_user

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
    review = Review.find_by_id params[:id]
    check_null review
    if review.destroy
     flash[:success] = t "reviews.success"
    else
      flash[:danger] = t "reviews.danger"
    end
    redirect_to :back
  end

  private
  def review_params
    params.require(:review).permit :content, :rated
  end
end
