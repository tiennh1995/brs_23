class LikesController < ApplicationController
  before_action :logged_in_user
  before_action :find_activity
  before_action :check_admin

  def create
    @like = current_user.likes.build
    @like.activity = @activity
    if @like.save
      respond_to do |format|
        format.html {redirect_to root_url}
        format.js
      end
    else
      flash[:danger] = t "action.danger"
      redirect_to root_url
    end
  end

  def destroy
    @like = Like.find_by_id params[:id]
    check_null @like
    @like.destroy
    @like = Like.new
    respond_to do |format|
      format.html {redirect_to root_url}
      format.js
    end
  end

  private
  def find_activity
    @activity = Activity.find_by_id params[:activity_id]
    check_null @activity
  end
end
