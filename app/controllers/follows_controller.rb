class FollowsController < ApplicationController
  before_action :logged_in_user

  def create
    @user = User.find_by_id params[:followed_id]
    check_null @user
    current_user.follow @user
    respond_to do |format|
      format.html {redirect_to @user}
      format.js
    end
  end

  def destroy
    @follow = Follow.find_by_id params[:id]
    check_null @follow
    @user = @follow.followed
    check_null @user
    current_user.unfollow @user
    respond_to do |format|
      format.html {redirect_to @user}
      format.js
    end
  end
end
