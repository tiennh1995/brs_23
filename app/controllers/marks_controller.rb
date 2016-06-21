class MarksController < ApplicationController
  before_action :logged_in_user
  before_action :correct_user
  def index
    @marks = current_user.marks
  end

  private
  def correct_user
    user = User.find params[:user_id]
    redirect_to root_url unless current_user? user
  end
end
